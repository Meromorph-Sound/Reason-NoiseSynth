classdef Click
    %Click Click generator functions
    %   Detailed explanation goes here
    
    enumeration
        Square, Triangular, HalfTriangleFall,HalfTriangleRise, Normal, Poisson, Delta,
        ExpFallHard, ExpFallSoft
    end
    
    
    methods 
        function func = law(obj)
            %law Get the shape law associated with this kind of click
            switch(obj)
                case Click.Square
                    func = @(x) 1;
                case Click.Triangular
                    func = @(x) 1-(abs(x-100)/100);
                case Click.HalfTriangleFall
                    func = @(x) max(0,1-(x/100));
                case Click.HalfTriangleRise
                    func = @(x) (x/100)*(x<100);
                case Click.Normal
                    func = @(x) exp(-(((x-100)/10)^2));
                case Click.Poisson
                    func = @(x) exp(-(x/10));
                case Click.Delta
                    func = @(x) (x<10);
                case Click.ExpFallHard
                    func = @(x) (1-exp(x-75))*(x<100);
                case Click.ExpFallSoft
                    func = @(x) (1-exp(x-200))*(x<100);
                otherwise
                    func = @(x) 0;
            end
        end
        
        function ys = coords(obj)
            xs=1:200;
            ys=arrayfun(obj.law(),xs);
        end  
        
        function p = plot(obj)
            ys=obj.coords();
            p = plot(ys,"Color","#14abf1","LineWidth",8);
            ax=gca;
            ax.Color ='#333333';
            ax.XColor = '#333333';
            ax.YColor = '#333333';
            ax.XLim = [-10 210];
            ax.YLim = [-0.1, 1.1];
            ax.DataAspectRatio = [220 1.2 1];
            ax.XTick=[];
            ax.XTickLabel=[];
            ax.YTick=[];
            ax.YTickLabel=[];
         
        end
        
        function n = name(obj)
            n=char(obj);
        end
        
        
        function filename = export(obj)
            pl = obj.plot();
            filename = join([obj.name(),"png"],".")
            exportgraphics(gcf,filename,"Resolution",300);
        end
        
        
        
    end
end

