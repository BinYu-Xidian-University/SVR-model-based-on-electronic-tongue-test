clear;
inputData=xlsread('C:\Users\dell\Desktop\SVM\svmDataTotal.xlsx');
x=inputData(1:9,:);
trainx=x(:,1:21);
trainx=trainx';
testx=x(:,22:28);
testx=testx';
y=inputData(10:16,:);
trainy=y(:,1:21);
trainy=trainy';
testy=y(:,22:28);
testy=testy';
[testyLine,testyColumn]=size(testy)
totalRightNum=0;
totalNum=0;
for i=1:1:testyColumn,
    mse = 10^7;
    for log2c = -10:0.5:3,
        for log2g = -10:0.5:3,
            cmd = ['-v 3 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g) , ' -s 3 -p 0.4 -t 2'];
            cv = svmtrain(trainy(:,i),trainx,cmd);
            if (cv < mse),
                mse = cv; bestc = 2^log2c; bestg = 2^log2g;
            end
        end
    end
    cmd = ['-c ', num2str(2^bestc), ' -g ', num2str(2^bestg) , ' -s 3 -p 0.4 -n 0.1'];
    model = svmtrain(trainy(:,i),trainx,cmd);
    [py,~,~] = svmpredict(trainy(:,i),trainx,model);
    [ptesty,~,~] = svmpredict(testy(:,i),testx,model);
    fprintf('the value of ptesty is %f\n',ptesty);
    [ptestyLine,ptestyColumn]=size(ptesty);

    for j=1:1:ptestyLine
        totalNum=totalNum+1;
        if(abs(ptesty(j,1)-testy(j,i))<=1)
          totalRightNum=totalRightNum+1;
        end
    end
    if (i==testyColumn),
        for j=1:1:9,
            figure(j);
            plot(trainx(:,j),trainy(:,i),'bo','linewidth',1.5);
            
            hold on;
            plot(trainx(:,j),py(:,1),'ro','linewidth',1.5); 
            plot(testx(:,j),testy(:,i),'bx','linewidth',1.5);
            plot(testx(:,j),ptesty(:,1),'rx','linewidth',1.5); 
            grid on;
            if (j==1),    
                axis([-17, -5, 0, 8]);
                title('Prediction of Maturities Based on Sourness with SVR','FontName','Times New Roman');   
                xlabel('Sourness','FontName','Times New Roman');        
                ylabel('Maturities','FontName','Times New Roman');       
                legend('Training Original Data','Regression Data', 'Testing Original Data', 'Predicted Data','FontName','Times New Roman');
            end
            if (j==2),    
                axis([1, 7, 0, 8]);
                title('Prediction of Maturities Based on Bitterness with SVR','FontName','Times New Roman');   
                xlabel('Bitterness','FontName','Times New Roman');        
                ylabel('Maturities','FontName','Times New Roman');    
                
            end
            if (j==3),    
                axis([0.7, 1.7, 0, 8]);
                title('Prediction of Maturities Based on Astringency with SVR','FontName','Times New Roman');   
                xlabel('Astringency','FontName','Times New Roman');        
                ylabel('Maturities','FontName','Times New Roman');
               
            end
            if (j==4),    
                axis([0, 3, 0, 8]);
                title('Prediction of Maturities Based on Aftertaste-B with SVR','FontName','Times New Roman');   
                xlabel('Aftertaste-B','FontName','Times New Roman');        
                ylabel('Maturities','FontName','Times New Roman'); 
              
            end
            if (j==5),    
                axis([0.05, 0.3, 0, 8]);
                title('Prediction of Maturities Based on Aftertaste-A with SVR','FontName','Times New Roman');   
                xlabel('Aftertaste-A','FontName','Times New Roman');        
                ylabel('Maturities','FontName','Times New Roman');        
            end
            if (j==6),    
                axis([3.5, 9.5, 0, 8]);
                title('Prediction of Maturities Based on Umami with SVR','FontName','Times New Roman');   
                xlabel('Umami','FontName','Times New Roman');        
                ylabel('Maturities','FontName','Times New Roman');        
            end
            if (j==7),    
                axis([0.6, 1.2, 0, 8]);
                title('Prediction of Maturities Based on Richness with SVR','FontName','Times New Roman');   
                xlabel('Richness','FontName','Times New Roman');        
                ylabel('Maturities','FontName','Times New Roman');        
            end
            if (j==8),    
                axis([-4, 2, 0, 8]);
                title('Prediction of Maturities Based on Saltiness with SVR','FontName','Times New Roman');   
                xlabel('Saltiness','FontName','Times New Roman');        
                ylabel('Maturities','FontName','Times New Roman');        
            end
            if (j==9),    
                axis([4, 10.5, 0, 8]);
                title('Prediction of Maturities Based on Sweetness with SVR','FontName','Times New Roman');   
                xlabel('Sweetness','FontName','Times New Roman');        
                ylabel('Maturities','FontName','Times New Roman');
            end
            
        end

    end
end
totalRightNum
totalNum
