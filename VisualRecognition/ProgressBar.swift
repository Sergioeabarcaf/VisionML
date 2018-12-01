import UIKit

class ProgressBar: UIView {
    private var innerProgress: CGFloat = 0.0
    
    var progress: CGFloat {
        set(newProgress){
            // validacion de que el progreso este en 0.0 y 1.0
            if newProgress > 1.0 {
                innerProgress = 1.0
            } else if  newProgress < 0.0{
                innerProgress = 0.0
            } else {
                innerProgress = newProgress
            }
            setNeedsDisplay()
        }
        
        get{
            //retornar el ancho de la fronteras por el valor de innerProgress
            return innerProgress * bounds.width
        }
    }
    
    //Toda clase UIView se debe sobreescribir la funcion DRAW
    override func draw(_ rect: CGRect) {
        drawProgressBar(frame: bounds, progress: progress)
    }
    
    func drawProgressBar(frame: CGRect = CGRect(x: 0, y: 1, width: 355, height: 14), progress: CGFloat = 200) {
        //Definicion de los colores
        let green = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
        let red = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        let yellow = UIColor(red: 240/255, green: 230/255, blue: 0.0, alpha:1.0)
        
        // Se crea una curva de Bezier
        let progressPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + 1, y: frame.minY + 1, width: frame.width - 2, height: frame.height - 2), cornerRadius: (frame.height - 2)/2)
        
        // Se configura el color a usar en el stroke
        if((progress/bounds.width) <= 0.6666) {
            red.setStroke()
        } else if ((progress/bounds.width) <= 0.83) {
            yellow.setStroke()
        } else {
            green.setStroke()
        }
        
        //Se realiza el pintado
        progressPath.lineWidth = 1
        progressPath.stroke()
        // esto es necesario para que se despinten los bordes del cornerRadius
        progressPath.addClip()
        
        //Se hace un pintado dinamico
        let progressActivePath = UIBezierPath(roundedRect: CGRect(x: 1, y: 1, width: progress, height: frame.height-2), cornerRadius: (frame.height-2)/2)
        
        if((progress/bounds.width) <= 0.66) {
            red.setFill()
        } else if ((progress/bounds.width) <= 0.83) {
            yellow.setFill()
        } else {
            green.setFill()
        }
        
        progressActivePath.fill()
        
        
        
    }
}
