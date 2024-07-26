clear data

%% Wage data, mthly

% Read column names from the excel sheet
colnames = readtable([Opt.datapath,'/62361-0009.xlsx'], 'Range', '6:6', 'ReadVariableNames', false);
colnames = table2cell(colnames)';

% Clean up the column names
colnames = replace(colnames, {'1. Quintil', '2. Quintil', '3. Quintil', '4. Quintil', '5. Quintil', 'Insgesamt'}, {'Q1', 'Q2', 'Q3', 'Q4', 'Q5', 'average'});
colnames = strcat('wage_n_',colnames);

% Read row names from the excel sheet, hard coded number of rows
rownames = readtable([Opt.datapath,'/62361-0009.xlsx'], 'Range', 'A7:B10000', 'ReadVariableNames', false);
rownames = rownames(~cellfun(@isempty,rownames.Var2),:);
rownames.Var1 = fillmissing(rownames.Var1, 'previous');

% Clean up the row names
rownames.Var2 = replace(rownames.Var2, {'Januar', 'Februar', 'März', 'April', 'Mai', 'Juni', 'Juli', 'August', 'September', 'Oktober', 'November', 'Dezember'}, {'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'});
rownames.period = datetime(strcat(rownames.Var1,rownames.Var2),'InputFormat','yyyyMMMM');

% Length of the data
nrows = size(rownames,1);

% Read the data
data_wages = readtable([Opt.datapath,'/62361-0009.xlsx'], 'Range', ['C7:H', num2str(nrows+6)], 'ReadVariableNames', false);

% Apply the column names
data_wages.Properties.VariableNames = colnames;

% Add row names as new variable as first column
data_wages.period = rownames.period;
data_wages = [data_wages(:,end),data_wages(:,1:end-1)];

%% Wage data, qrtly

% Hard-coded column names
colnames = {'wage_r_average_qrtly'};

% Read row names from the excel sheet
rownames = readtable([Opt.datapath,'/62361-0010.xlsx'], 'Range', 'A6:B10000', 'ReadVariableNames', false);
rownames = rownames(~cellfun(@isempty,rownames.Var2),:);
rownames.Var1 = fillmissing(rownames.Var1, 'previous');

% Clean up the row names
rownames.Var2 = replace(rownames.Var2, {'1. Quartal', '2. Quartal', '3. Quartal', '4. Quartal'}, {'January', 'April', 'July', 'October'});
rownames.period = datetime(strcat(rownames.Var1,rownames.Var2),'InputFormat','yyyyMMMM');

% Length of the data
nrows = size(rownames,1);

% Read the data
data_wages_qrtly = readtable([Opt.datapath,'/62361-0010.xlsx'], 'Range', ['C6:C', num2str(nrows+5)], 'ReadVariableNames', false);

% Apply the column names
data_wages_qrtly.Properties.VariableNames = colnames;

% Add row names as new variable as first column
data_wages_qrtly.period = rownames.period;
data_wages_qrtly = [data_wages_qrtly(:,end),data_wages_qrtly(:,1:end-1)];

%% Price data, mthly

% Hard-coded column names
colnames = {'CPI'};

% Read row names from the excel sheet
rownames = readtable([Opt.datapath,'/61111-0002.xlsx'], 'Range', 'A6:B10000', 'ReadVariableNames', false);
rownames = rownames(~cellfun(@isempty,rownames.Var2),:);
rownames.Var1 = fillmissing(rownames.Var1, 'previous');

% Clean up the row names
rownames.Var2 = replace(rownames.Var2, {'Januar', 'Februar', 'März', 'April', 'Mai', 'Juni', 'Juli', 'August', 'September', 'Oktober', 'November', 'Dezember'}, {'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'});
rownames.period = datetime(strcat(rownames.Var1,rownames.Var2),'InputFormat','yyyyMMMM');

% Length of the data
nrows = size(rownames,1);

% Read the data
data_prices = readtable([Opt.datapath,'/61111-0002.xlsx'], 'Range', ['C6:C', num2str(nrows+5)], 'ReadVariableNames', false);

% Apply the column names
data_prices.Properties.VariableNames = colnames;

% Add row names as new variable as first column
data_prices.period = rownames.period;
data_prices = [data_prices(:,end),data_prices(:,1:end-1)];

%% Wage data, qrtly, Haver

% Hard-coded column names
colnames = {'ha_wage_n', 'ha_wage_r', 'ha_wage_n_sa', 'ha_wage_r_sa'};

% Read row names from the excel sheet, hard coded number of rows
rownames = readtable([Opt.datapath,'/germany-wages.xlsx'], 'Range', 'B44:B111', 'ReadVariableNames', false);
rownames.year = year(rownames.Var1);
rownames.quarter = quarter(rownames.Var1);
rownames.month = (rownames.quarter-1)*3+1;
rownames.period = datetime(rownames.year, rownames.month, 1, 'InputFormat','yyyyMMMM');

% Length of the data
nrows = size(rownames,1);

% Read the data
data_wages_haver = readtable([Opt.datapath,'/germany-wages.xlsx'], 'Range', ['C44:F',num2str(nrows+43)], 'ReadVariableNames', false);

% Apply the column names
data_wages_haver.Properties.VariableNames = colnames;

% Add row names as new variable as first column
data_wages_haver.period = rownames.period;
data_wages_haver = [data_wages_haver(:,end), data_wages_haver(:,1:end-1)];

% Compute year-on-year growth rates
data_wages_haver.ha_wage_n_yoy = [NaN; diff(data_wages_haver.ha_wage_n) ./ data_wages_haver.ha_wage_n(1:end-1)] .* 100;
data_wages_haver.ha_wage_r_yoy = [NaN; diff(data_wages_haver.ha_wage_r) ./ data_wages_haver.ha_wage_r(1:end-1)] .* 100;
data_wages_haver.ha_wage_n_sa_yoy = [NaN; diff(data_wages_haver.ha_wage_n_sa) ./ data_wages_haver.ha_wage_n_sa(1:end-1)] .* 100;
data_wages_haver.ha_wage_r_sa_yoy = [NaN; diff(data_wages_haver.ha_wage_r_sa) ./ data_wages_haver.ha_wage_r_sa(1:end-1)] .* 100;

%% Merge the data

% Merge the data
data = outerjoin(data_prices, data_wages, 'MergeKeys', true);
data = outerjoin(data, data_wages_qrtly, 'MergeKeys', true);
data = outerjoin(data, data_wages_haver, 'MergeKeys', true);

%% Rebase the data

% set January 2022 observation to 100
data.CPI = data.CPI / data.CPI(data.period == datetime(2022,1,1)) * 100;
data.wage_n_Q1 = data.wage_n_Q1 / data.wage_n_Q1(data.period == datetime(2022,1,1)) * 100;
data.wage_n_Q2 = data.wage_n_Q2 / data.wage_n_Q2(data.period == datetime(2022,1,1)) * 100;
data.wage_n_Q3 = data.wage_n_Q3 / data.wage_n_Q3(data.period == datetime(2022,1,1)) * 100;
data.wage_n_Q4 = data.wage_n_Q4 / data.wage_n_Q4(data.period == datetime(2022,1,1)) * 100;
data.wage_n_Q5 = data.wage_n_Q5 / data.wage_n_Q5(data.period == datetime(2022,1,1)) * 100;
data.wage_n_average = data.wage_n_average / data.wage_n_average(data.period == datetime(2022,1,1)) * 100;
data.wage_r_average_qrtly = data.wage_r_average_qrtly / data.wage_r_average_qrtly(data.period == datetime(2022,1,1)) * 100;

%% Compute real wages

% real wage = nominal wage / price level
data.wage_r_Q1 = data.wage_n_Q1 ./ data.CPI * 100;
data.wage_r_Q2 = data.wage_n_Q2 ./ data.CPI * 100;
data.wage_r_Q3 = data.wage_n_Q3 ./ data.CPI * 100;
data.wage_r_Q4 = data.wage_n_Q4 ./ data.CPI * 100;
data.wage_r_Q5 = data.wage_n_Q5 ./ data.CPI * 100;
data.wage_r_average = data.wage_n_average ./ data.CPI * 100;

%% Save the data

% keep if period >= Opt.xmin
data = data(data.period >= Opt.xmin, :);

% Save the data to disc
data_wages = data;
save([Opt.respath,'/data/wages.mat'], 'data_wages')
disp('Wage data saved to disc.')

clear data

%% Trade data

sheets = {'TB', 'X', 'M', 'TB_EUR', 'X_EUR', 'M_EUR'};
for i = 1:length(sheets)
    
    sheet = sheets{i};
    
    if ~strcmp(sheet, 'EUR')
        
        % Read column names from the excel sheet
        colnames = readtable([Opt.datapath, 'bilateral-trade.xlsx'], 'Sheet', sheet, 'Range', '1:2', 'ReadVariableNames', false);
        colnames = table2cell(colnames)';
        
        % Clean up the column names
        colnames(1,1) = {'period'};
        colnames(1,2) = {'period'};
        
        if strcmp(sheet, 'TB')
            colnames = cellfun(@(x) strrep(x, 'Germany: Trade Balance with ', ''), colnames, 'UniformOutput', false);
        elseif strcmp(sheet, 'X')
            colnames = cellfun(@(x) strrep(x, 'Germany: Exports to ', ''), colnames, 'UniformOutput', false);
        elseif strcmp(sheet, 'M')
            colnames = cellfun(@(x) strrep(x, 'Germany: Imports [cif] from ', ''), colnames, 'UniformOutput', false);
        end
        
        colnames = cellfun(@(x) strrep(x, '(Mil.US$)', ''), colnames, 'UniformOutput', false);
        colnames = cellfun(@(x) strtrim(x), colnames, 'UniformOutput', false);
        colnames = cellfun(@(x) strrep(x, '&', 'and'), colnames, 'UniformOutput', false);
        colnames = cellfun(@(x) strrep(x, '-', '_'), colnames, 'UniformOutput', false);
        colnames = cellfun(@(x) strrep(x, '''', ''), colnames, 'UniformOutput', false);
        colnames = cellfun(@(x) strrep(x, ' ', '_'), colnames, 'UniformOutput', false);
        
        % Hard-coded fixes
        if strcmp(sheet, 'X') || strcmp(sheet, 'M')
            colnames(strcmp(colnames, 'Slovakia')) = {'Slovak_Republic'};
            colnames(strcmp(colnames, 'U.K.')) = {'United_Kingdom'};
            colnames(strcmp(colnames, 'U.S.')) = {'United_States'};
            colnames(strcmp(colnames, 'P.R._China')) = {'China'};
            colnames(strcmp(colnames, 'Lao_P.D.R.')) = {'Lao_PDR'};
            colnames(strcmp(colnames, 'Viet_Nam')) = {'Vietnam'};
            colnames(strcmp(colnames, 'Asia,_ns')) = {'Asia_ns'};
            colnames(strcmp(colnames, 'Germany:_Imports_[cif]_From_Kosovo')) = {'Kosovo'};
            colnames(strcmp(colnames, 'Serbia/Montenegro_[DISC]')) = {'Serbia_and_Montenegro_[DISC]'};
            colnames(strcmp(colnames, 'Europe,_ns')) = {'Europe_ns'};
            colnames(strcmp(colnames, 'Cent_African_Republic')) = {'Central_African_Republic'};
            colnames(strcmp(colnames, 'Congo,_Dem_Rep')) = {'Democratic_Republic_of_Congo'};
            colnames(strcmp(colnames, 'Rep_of_Congo')) = {'Republic_of_Congo'};
            colnames(strcmp(colnames, 'Eq_Guinea')) = {'Equatorial_Guinea'};
            colnames(strcmp(colnames, 'Africa,_ns')) = {'Africa_ns'};
            colnames(strcmp(colnames, 'Bahamas')) = {'The_Bahamas'};
            colnames(strcmp(colnames, 'Dominican_Rep')) = {'Dominican_Republic'};
            colnames(strcmp(colnames, 'St._Vincent_and_Grenadines')) = {'St._Vincent_and_the_Grenadines'};
            colnames(strcmp(colnames, 'W_Hemisphere,_nec')) = {'Western_Hemisphere_ns'};
            colnames(strcmp(colnames, 'Western_Hemisphere,_nec')) = {'Western_Hemisphere_ns'};
            colnames(strcmp(colnames, 'Kyrgyzstan')) = {'Kyrgyz_Republic'};
            colnames(strcmp(colnames, 'West_Bank/Gaza_Strip')) = {'West_Bank_and_Gaza'};
            colnames(strcmp(colnames, 'Yemen,_Rep_of')) = {'Republic_of_Yemen'};
            colnames(strcmp(colnames, 'Yemen,_PDR_[DISC]')) = {'PDR_Yemen_[DISC]'};
            colnames(strcmp(colnames, 'Yemen_Arab_Rep_[DISC]')) = {'Yemen_Arab_Republic_[DISC]'};
            colnames(strcmp(colnames, 'Middle_East,_ns')) = {'Middle_East_ns'};
            colnames(strcmp(colnames, 'Other_Ctys,_nie')) = {'Other_Countries_nie'};
        end
        
        if strcmp(sheet, 'TB')
            colnames_TB = colnames;
        elseif strcmp(sheet, 'X')
            colnames_X = colnames;
        elseif strcmp(sheet, 'M')
            colnames_M = colnames;
        end
        
    end
    
    if strcmp(sheet, 'TB') || strcmp(sheet, 'TB_EUR')
        colnames = colnames_TB;
    elseif strcmp(sheet, 'X') || strcmp(sheet, 'X_EUR')
        colnames = colnames_X;
    elseif strcmp(sheet, 'M') || strcmp(sheet, 'M_EUR')
        colnames = colnames_M;
    end
    
    % Read the data from the excel sheet
    data.mthly.(sheet) = readtable([Opt.datapath, 'bilateral-trade.xlsx'], 'Sheet', sheet, 'Range', '14:179', 'ReadVariableNames', false);
    
    % Apply the column names to the table
    data.mthly.(sheet).Properties.VariableNames = colnames(:,2);
    
    % Convert the first column to datetime from YYYYMM
    data.mthly.(sheet).period = datetime(data.mthly.(sheet).period, 'InputFormat', 'yyyyMM');
    
    % Aggregate from mthly to qrtly
    data.qrtly.(sheet) = data.mthly.(sheet);
    data.qrtly.(sheet).year = year(data.qrtly.(sheet).period);
    data.qrtly.(sheet).quarter = quarter(data.qrtly.(sheet).period);
    data.qrtly.(sheet).period = [];
    data.qrtly.(sheet) = data.qrtly.(sheet)(:, [end-1, end, 1:end-2]);
    
    data.qrtly.(sheet) = varfun(@sum, data.qrtly.(sheet), 'GroupingVariables', {'year', 'quarter'}, 'InputVariables', data.qrtly.(sheet).Properties.VariableNames(3:end));
    
    data.qrtly.(sheet).period = datetime(data.qrtly.(sheet).year, data.qrtly.(sheet).quarter*3 - 2, 1);
    data.qrtly.(sheet).year = [];
    data.qrtly.(sheet).quarter = [];
    data.qrtly.(sheet) = data.qrtly.(sheet)(:, [end, 1:end-1]);
    
    data.qrtly.(sheet).Properties.VariableNames = cellfun(@(x) strrep(x, 'sum_', ''), data.qrtly.(sheet).Properties.VariableNames, 'UniformOutput', false);
    
    data.qrtly.(sheet) = data.qrtly.(sheet)(data.qrtly.(sheet).GroupCount == 3, :);
    
    % Aggregate from mthly to biannly
    data.biannly.(sheet) = data.mthly.(sheet);
    data.biannly.(sheet).year = year(data.biannly.(sheet).period);
    data.biannly.(sheet).quarter = quarter(data.biannly.(sheet).period);
    data.biannly.(sheet).semester = (data.biannly.(sheet).quarter > 2) + 1;
    data.biannly.(sheet).period = [];
    data.biannly.(sheet).quarter = [];
    data.biannly.(sheet) = data.biannly.(sheet)(:, [end-1, end, 1:end-2]);
    
    data.biannly.(sheet) = varfun(@sum, data.biannly.(sheet), 'GroupingVariables', {'year', 'semester'}, 'InputVariables', data.biannly.(sheet).Properties.VariableNames(3:end));
    
    data.biannly.(sheet).period = datetime(data.biannly.(sheet).year, data.biannly.(sheet).semester*6 - 5, 1);
    data.biannly.(sheet).year = [];
    data.biannly.(sheet).semester = [];
    data.biannly.(sheet) = data.biannly.(sheet)(:, [end, 1:end-1]);
    
    data.biannly.(sheet).Properties.VariableNames = cellfun(@(x) strrep(x, 'sum_', ''), data.biannly.(sheet).Properties.VariableNames, 'UniformOutput', false);
    
    data.biannly.(sheet) = data.biannly.(sheet)(data.biannly.(sheet).GroupCount == 6, :);
    
    % Aggregate from mthly to annly
    data.annly.(sheet) = data.mthly.(sheet);
    data.annly.(sheet).year = year(data.annly.(sheet).period);
    data.annly.(sheet).period = [];
    data.annly.(sheet) = data.annly.(sheet)(:, [end, 1:end-1]);
    
    data.annly.(sheet) = varfun(@sum, data.annly.(sheet), 'GroupingVariables', {'year'}, 'InputVariables', data.annly.(sheet).Properties.VariableNames(2:end));
    
    data.annly.(sheet).period = datetime(data.annly.(sheet).year, 1, 1);
    data.annly.(sheet).year = [];
    data.annly.(sheet) = data.annly.(sheet)(:, [end, 1:end-1]);
    
    data.annly.(sheet).Properties.VariableNames = cellfun(@(x) strrep(x, 'sum_', ''), data.annly.(sheet).Properties.VariableNames, 'UniformOutput', false);
    
    data.annly.(sheet) = data.annly.(sheet)(data.annly.(sheet).GroupCount == 12, :);
    
end

%% Compute some additional aggregates
% aggregate the data for the following countries into a diversion group
countries = {
    'Kyrgyz_Republic';
    'Armenia';
    'Azerbaijan';
    'Georgia';
    'Kazakhstan';
    'Turkey';
    'Uzbekistan';
    };

for i = 1:length(sheets)
    
    sheet = sheets{i};
    
    data.mthly.(sheet).Diversion = sum(data.mthly.(sheet){:,countries}, 2);
    data.qrtly.(sheet).Diversion = sum(data.qrtly.(sheet){:,countries}, 2);
    data.biannly.(sheet).Diversion = sum(data.biannly.(sheet){:,countries}, 2);
    data.annly.(sheet).Diversion = sum(data.annly.(sheet){:,countries}, 2);
    
end

%% Save the data

% keep if period >= Opt.xmin
for i = 1:length(sheets)
    sheet = sheets{i};
    data.mthly.(sheet) = data.mthly.(sheet)(data.mthly.(sheet).period >= Opt.xmin, :);
    data.qrtly.(sheet) = data.qrtly.(sheet)(data.qrtly.(sheet).period >= Opt.xmin, :);
    data.biannly.(sheet) = data.biannly.(sheet)(data.biannly.(sheet).period >= Opt.xmin, :);
    data.annly.(sheet) = data.annly.(sheet)(data.annly.(sheet).period >= Opt.xmin, :);
end

% Save the data to disc
data_trade = data;
save([Opt.respath,'/data/bilateral-trade.mat'], 'data_trade')
disp('Trade data saved to disc.')

clear data

%% Energy price data, mthly, Haver

% Hard-coded column names
colnames = {'coal_australia', 'coal_south_africa', 'oil', 'oil_brent', 'oil_dubai', 'oil_wti', 'gas_europe', 'gas_us', 'gas_japan', 'gas_index'};

% Read row names from the excel sheet, hard coded number of rows
rownames = readtable([Opt.datapath,'/energy-prices.xlsx'], 'Range', 'A13:A303', 'ReadVariableNames', false, 'Sheet', 'Sheet2');
rownames.period = datetime(rownames.Var1, 'InputFormat','MMM-yyyy');

% Length of the data
nrows = size(rownames,1);

% Read the data
data_energy = readtable([Opt.datapath,'/energy-prices.xlsx'], 'Range', ['B13:K',num2str(nrows+12)], 'ReadVariableNames', false, 'Sheet', 'Sheet2');

% Apply the column names
data_energy.Properties.VariableNames = colnames;

% Add row names as new variable as first column
data_energy.period = rownames.period;
data = [data_energy(:,end), data_energy(:,1:end-1)];

%% Save the data

% keep if period >= Opt.xmin
data = data(data.period >= Opt.xmin, :);

% Save the data to disc
data_energy = data;
save([Opt.respath,'/data/energy.mat'], 'data_energy')
disp('Energy price data saved to disc.')

clear data