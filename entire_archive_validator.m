clc
close all
clearvars

folderSemester = uigetdir('I:\CourseArchive',"Select Semester Folder");
courseList = dir(folderSemester);
courseList(~[courseList.isdir]) = [];
courseList(1:2) = [];

XLS{1,1} = 'Course ID';
XLS{1,2} = 'Handouts';
XLS{1,3} = 'Syllabus';
XLS{1,4} = 'Grades CSV';
XLS{1,5} = '# assignments';
XLS{1,6} = '# missing student products';

for t = 1:numel(courseList)
    XLS{t+1,1} = courseList(t).name;
    handoutsList = dir(fullfile(folderSemester,courseList(t).name,'Handouts'));
    XLS{t+1,2} = numel(handoutsList)-2;
    
    if isfile(fullfile(folderSemester,courseList(t).name,'syllabus.pdf'))
       XLS{t+1,3} = 1;
    else
       XLS{t+1,3} = 0;
    end

    XLS{t+1,4} = numel(dir(fullfile(folderSemester,courseList(t).name,'Work_Products\*.csv')));

    workList = dir(fullfile(folderSemester,courseList(t).name,'Work_Products'));
    XLS{t+1,5} = sum([workList.isdir])-2;
    missingProducts = 0;
    for z = 3:numel(workList)
        if workList(z).isdir
           fileS1 = dir(fullfile(workList(z).folder,workList(z).name,'s1.pdf'));
           fileS2 = dir(fullfile(workList(z).folder,workList(z).name,'s2.pdf'));
           fileS3 = dir(fullfile(workList(z).folder,workList(z).name,'s3.pdf'));
           missingProducts = missingProducts + 3-numel(fileS1)-numel(fileS2)-numel(fileS3);
        end
    end
    XLS{t+1,6} = missingProducts;
     


end

