%Render Letter
%Displays a letter at the specified position
function Render_Letter(plot, color, Origin, Letter) 
  figure(plot);
  hold on;
  text(Origin(1), Origin(2), Origin(3), Letter,'HorizontalAlignment','right');
  hold off;
end