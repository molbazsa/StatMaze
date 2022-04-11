function [table_overall_a] = Data()
    warning("off")
    a_tableinfo=readtable('Armedforces2020.xlsx');
    for i = 1:1:size(a_tableinfo.feed.entry,1)
        Entity_a(i) = string(a_tableinfo.feed.entry{i}.gsx_entity.x_t);
        Code_a(i) = string(a_tableinfo.feed.entry{i}.code.x_t);
        Year_a(i) = str2double(string(a_tableinfo.feed.entry{i}.gsx_year.x_t));
        Armedforcespersonneltotal_a(i) = str2double(string(a_tableinfo.feed.entry{i}.gsx_armedforcespersonneltotal.x_t));
    end
    table_overall_a = table(Entity_a',Code_a',Year_a',Armedforcespersonneltotal_a');
    table_overall_a.Properties.VariableNames = {'Entity' 'Code' 'Year' ' Armedforcespersonneltotal'};
end

