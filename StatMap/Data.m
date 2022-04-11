function [table_overall_a] = Data()
    warning("off")
    a_tableinfo=readtable('Armedforces2020.xlsx');
    for i = 1:1:size(a_tableinfo,1)
        Entity_a(i) = string(a_tableinfo.Entity(i));
        Code_a(i) = string(a_tableinfo.Code(i));
        Year_a(i) = str2double(string(a_tableinfo.Year(i)));
        Armedforcespersonneltotal_a(i) = str2double(string(a_tableinfo.ArmedForcesPersonnel_Total(i)));
    end
    table_overall_a = table(Entity_a',Code_a',Year_a',Armedforcespersonneltotal_a');
    table_overall_a.Properties.VariableNames = {'Entity' 'Code' 'Year' ' Armedforcespersonneltotal'};
end

