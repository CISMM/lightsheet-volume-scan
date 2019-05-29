classdef NI < handle
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        session
        i_blanking % index of blanking in out_data
        i_488
        i_561
        i_mirx
        i_miry
        i_etl3
        out_data
    end
    
    methods
        function obj = NI()
            %UNTITLED5 Construct an instance of this class
            %   Detailed explanation goes here
            obj.i_blanking = 1;
            obj.i_488 = 2;
            obj.i_561 = 3;
            obj.i_mirx = 4;
            obj.i_miry = 5;   
            obj.i_etl3 = 6;
            obj.out_data = [];
            obj.create_session();
        end
        
        function create_session(obj)
            % Dev1: 0-blanking, 1-488, 2-561
            % Dev4: 0-mirx, 1
            obj.session = daq.createSession('ni');
            % addAnalogOutputChannel(obj.session, 'Dev1', 0:2, 'Voltage');
            addAnalogOutputChannel(obj.session, 'Dev1', 'ao0', 'Voltage');
            addAnalogOutputChannel(obj.session, 'Dev1', 'ao2', 'Voltage');
            addAnalogOutputChannel(obj.session, 'Dev1', 'ao4', 'Voltage');
            addAnalogOutputChannel(obj.session, 'Dev4', 0:2, 'Voltage');
            obj.out_data = [10, 0, 0, 0, 0, 4.76];
        end
        
        function start(obj)
            queueOutputData(obj.session, obj.out_data);
            startForeground(obj.session);
        end
        
        function delete(obj)
            % destructor
        end
        
        function set_mir(obj, v)
            obj.out_data(obj.i_mirx) = -v;
            obj.out_data(obj.i_miry) = v;
            obj.start();
        end
        
        function set_488(obj, v)
            obj.out_data(obj.i_488) = v;
            obj.start();
        end
        
        function set_561(obj, v)
            obj.out_data(obj.i_561) = v;
            obj.start();
        end
        
        function set_mirx(obj, v)
            obj.out_data(obj.i_mirx) = v;
            obj.start();
        end
        
        function set_miry(obj, v)
            obj.out_data(obj.i_miry) = v;
            obj.start();
        end
        
        function set_etl3(obj, v)
            obj.out_data(obj.i_etl3) = v;
            obj.start();
        end
    end
end

