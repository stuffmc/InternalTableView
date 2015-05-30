I think I know the answer. Basically, I knew it wasn't a super smart idea to have a TableView inside another one, the first one being Static the other one Dynamic (which I should have stated).

Then I remembered as soon as you implement any of the delegates (e.g. `cellForRow`) you'll need to implement them all...

To sumarize, what I wanted to do can be done with only 1 TableView and using the `TableViewHeader`, which is what I'll do and what people should do, if they start seeing those weird messages coming.

————————

I'm having a `UITableViewController` which has a `TableView` in which I have a Cell which has another `TableView` in it. 

When that internal `TableView` tries `dequeueReusableCellWithIdentifier` for indexPath `(1,0)` the app crashes with

    Terminating app due to uncaught exception 'NSRangeException', 
    reason: '*** -[__NSArrayI objectAtIndex:]: index 1 beyond bounds [0 .. 0]'

Although that internal `TableView` clearly has 3 sections. The stack trace being:

	-[__NSArrayI objectAtIndex:] + 190
	-[UITableViewDataSource tableView:indentationLevelForRowAtIndexPath:] + 61
	-[UITableView _configureCellForDisplay:forIndexPath:]_block_invoke + 1711
	+[UIView(Animation) performWithoutAnimation:] + 65
	-[UITableView _configureCellForDisplay:forIndexPath:] + 312
	-[UITableView dequeueReusableCellWithIdentifier:forIndexPath:] + 271

Because of the trace, I tried implementing

    override func tableView(tableView: UITableView, 
                  indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
      return 0
    }

but then the app crashes at

    -[UITableViewDataSource tableView:viewForFooterInSection:]

with the same `index 1 beyond bounds [0 .. 0]`...

The implementation is relatively irrelevant IMHO, but there it is

    override func tableView(tableView: UITableView, 
                  cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      if tableView.tag == 0 {
        return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
      }
      if let cell = tableView.dequeueReusableCellWithIdentifier("cell") as? UITableViewCell {
        return cell
      }
      return UITableViewCell() // Shouldn't happen.
    }

I'm not super proud of that last line :) but what else would you do to please the compiler? I never reach that line. The crash clearly happens in the internal `TableView` which has a `tag` of 1.
