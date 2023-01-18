function TotalGeometry = Geometry(OD, ND, grid_step_mm, index, TotalGeometry_old)
    N1 = evalin('base','N1');N2 = evalin('base','N2');
    disk_diameter_pt = round(OD/grid_step_mm+1);
    disk_diameter_pt_2 = round(ND/grid_step_mm+1);
    SE = strel('disk', round((disk_diameter_pt+1)/2),0);
    S2 = strel('disk', round((disk_diameter_pt_2+1)/2),0);
    scatterer = getnhood(SE)*index;
    scatterer2 = getnhood(S2)*index;
    [M1,M2] = size(scatterer);
    [M3,M4] = size(scatterer2);
    geometry = uint8(zeros(N1,N2)); geometry2 = uint8(zeros(N1,N2));
    geometry((N1-M1)/2+1:(N1+M1)/2,(N2-M2)/2+1:(N2+M2)/2) = uint8(scatterer);
    geometry2((N1-M3)/2+1:(N1+M3)/2,(N2-M4)/2+1:(N2+M4)/2) = uint8(scatterer2);
    TotalGeometry = TotalGeometry_old + geometry - geometry2;
end