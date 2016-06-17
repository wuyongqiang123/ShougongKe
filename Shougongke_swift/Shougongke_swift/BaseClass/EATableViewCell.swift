

import Foundation

@objc(EATableViewCell)
class EATableViewCell : UITableViewCell
{
    override func layoutSubviews()
    {
        super.layoutSubviews()
        self.spUpdateLayout()
    }
}

func getSuperCell(var view : UIView?) -> UITableViewCell?
{
    while view != nil && !(view!.isKindOfClass(UITableViewCell.classForCoder()))
    {
        view = view!.superview
    }
    return view as? UITableViewCell
}
