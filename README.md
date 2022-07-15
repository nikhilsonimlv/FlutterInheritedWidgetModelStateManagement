# flutter_inherited_state_management

In this project we will use inherited model which allow us to redraw ONLY relevant parts of our widget tree.
Think of something like an Ancestor — Descendant widget relationship where multiple Descendant widgets
are dependent on properties of their common Ancestor Widget. Now, when one single property of the
Ancestor changes, you would not want all the descendants to be rebuild, instead you would want only those Descendant widgets
to rebuild who care about the changes made to a particular property of the Ancestor Widget.
This is where InheritedModel comes in.
Inherited model decides either to draw all his descendants and WHICH descendant should be REDRAW.
Each and every descendant in widget tree listen to an specific aspect/property of the inherited widget.
Important :- Inherited-widget-model is NOT a stateful widget , it has constant constructor , we wrap it inside stateful widget to make them stateful

Calling MyModel.of(context, 'foo') means that context should only be rebuilt when the foo aspect of MyModel changes. If the aspect is null, then the model supports all aspects.
