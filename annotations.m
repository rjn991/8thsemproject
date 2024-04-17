% Define the directory containing the images and annotations
imageDir = '.';
annotationFile = 'annotations.txt';

% Read annotations from the text file
annotations = importdata(fullfile(imageDir, annotationFile));

% Define mappings for class and pose IDs
classMap = {'NA', 'Crossing', 'Waiting', 'Queueing', 'Walking', 'Talking'};
poseMap = {'Right', 'Front-right', 'Front', 'Front-left', 'Left', 'Back-left', 'Back', 'Back-right'};

% Get a list of image files in the directory
imageFiles = dir(fullfile(imageDir, '*.jpg'));

% Create a figure to display the images
figure;

% Iterate through each image file
for i = 1:numel(imageFiles)
    % Read the image
    img = imread(fullfile(imageDir, imageFiles(i).name));
    
    % Get annotations for the current frame
    frameAnnotations = annotations(annotations(:,1) == i,:);
    
    % Display the image
    imshow(img);
    hold on;
    
    % Iterate through each annotation for the current frame
    for j = 1:size(frameAnnotations, 1)
        % Extract bounding box coordinates and other annotation details
        x = frameAnnotations(j, 2);
        y = frameAnnotations(j, 3);
        width = frameAnnotations(j, 4);
        height = frameAnnotations(j, 5);
        classID = frameAnnotations(j, 6);
        poseID = frameAnnotations(j, 7);
        
        % Draw bounding box
        rectangle('Position', [x, y, width, height], 'EdgeColor', 'r', 'LineWidth', 2);
        
        % Add class label
        classLabel = classMap{classID};
        text(x, y - 10, classLabel, 'Color', 'red', 'FontSize', 10, 'FontWeight', 'bold');
        
        % Add pose label if it's not -1
        if poseID ~= -1
            poseLabel = poseMap{poseID};
            text(x, y - 25, poseLabel, 'Color', 'red', 'FontSize', 10, 'FontWeight', 'bold');
        end
    end
    
    % Set title
    title(sprintf('Frame %d', i));
    
    % Hold off to prevent further drawing on the current image
    hold off;
    
    % Pause to simulate video playback
    pause(0.1); % Adjust the pause duration as needed
end
