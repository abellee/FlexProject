package functional
{
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    import mx.core.mx_internal;
    
    import spark.components.VScrollBar;
    import spark.core.IViewport;
    
    use namespace mx_internal;
    
    public class CustomVScrollBar extends VScrollBar
    {
        /**
         *  Override mouseWheelHandler to scroll by a fixed amount
         * 
         *  See superclass for example of how this normally works
         */
        override mx_internal function mouseWheelHandler(event:MouseEvent):void
        {
            const vp:IViewport = viewport;
            if (event.isDefaultPrevented() || !vp || !vp.visible)
                return;
            
            var delta:Number = event.delta;
            var direction:Number = 0;
            var distance:Number = 50;
            // figure out the direction of scroll
            if (delta < 0){
                direction = 1;
            } else if (delta == 0){
                direction = 0;
            } else {
                direction = -1;
            }
			
            vp.verticalScrollPosition += distance * direction;
            event.preventDefault();
        }

    }
}