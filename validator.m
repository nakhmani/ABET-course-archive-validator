function validator()

passFlag = true;

%% read the ABET course folder
courseFolder = uigetdir("","Select Your ABET Course Folder");

%% verify if Syllabus.pdf exists in the main folder
if ~isfile(fullfile(courseFolder,'syllabus.pdf'))
    msgbox(["The file Syllabus.pdf is missing."; "Add Syllabus.pdf file in your main course folder ";courseFolder;...
        "If you have an HTML or DOC format, save or print it as PDF.";"File name is not case sensitive."])
    passFlag = false;
end

%% verify if both required folders exist
if ~exist(fullfile(courseFolder,'Handouts'), 'dir')
    msgbox(["The folder Handouts does not exist!";"Create the folder Handouts inside the folder ";courseFolder])
    passFlag = false;
end

%% verify if both required folders exist
if ~exist(fullfile(courseFolder,'Work_Products'), 'dir')
    msgbox(["The folder Handouts does not exist!";"Create the folder Work_Products inside the folder ";courseFolder])
    passFlag = false;
end

%% count the number of files in the Handouts folder
handoutsList = dir(fullfile(courseFolder,'Handouts'));
N = numel(handoutsList)-2;
if N == 0
    msgbox(["You do not have any files in the Handouts folder";"It is recommended to have at least 3 handouts."])
    passFlag = false;
elseif numel(handoutsList) < 3
    msgbox(["You have " + num2str(N) + " files in the Handouts folder.";"It is recommended to have at least 3 handouts."])
end

%% verify if grades file is available
if numel(dir(fullfile(courseFolder,'Work_Products\*.csv'))) ~= 1
    msgbox(["(Optional) You might want to add CSV file with all grades exported from Canvas into the folder: ";...
        fullfile(courseFolder,'Work_Products')])
end

%% list all assignments and tests
assignmentsList = dir(fullfile(courseFolder,'Work_Products'));
assignmentsList(1:2) = []; % remove '.' and '..' folders

%% verify if all S1, S2, S3 files present
for assignment = 1:numel(assignmentsList)
    if assignmentsList(assignment).isdir
        fileS1 = dir(fullfile(assignmentsList(assignment).folder,assignmentsList(assignment).name,'s1.pdf'));
        fileS1zip = dir(fullfile(assignmentsList(assignment).folder,assignmentsList(assignment).name,'s1.zip'));
        fileS2 = dir(fullfile(assignmentsList(assignment).folder,assignmentsList(assignment).name,'s2.pdf'));
        fileS2zip = dir(fullfile(assignmentsList(assignment).folder,assignmentsList(assignment).name,'s2.zip'));
        fileS3 = dir(fullfile(assignmentsList(assignment).folder,assignmentsList(assignment).name,'s3.pdf'));
        fileS3zip = dir(fullfile(assignmentsList(assignment).folder,assignmentsList(assignment).name,'s3.zip'));
        if numel(fileS1)+numel(fileS1zip)<1
            msgbox(["File S1.pdf or S1.zip is missing in the folder: ";...
                fullfile(assignmentsList(assignment).folder,assignmentsList(assignment).name)])
            passFlag = false;
        end
        if numel(fileS2)+numel(fileS2zip)<1
            msgbox(["File S2.pdf or S2.zip is missing in the folder: ";...
                fullfile(assignmentsList(assignment).folder,assignmentsList(assignment).name)])
            passFlag = false;
        end
        if numel(fileS3)+numel(fileS3zip)<1
            msgbox(["File S3.pdf or S3.zip is missing in the folder: ";...
                fullfile(assignmentsList(assignment).folder,assignmentsList(assignment).name)])
            passFlag = false;
        end
    end
end

%% check if all required conditions were satisfied
if passFlag
    msgbox("Congratulations! You have successfully completed all requirements!")
else
    msgbox("More work needs to be done.")
end




