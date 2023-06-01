import terminatorlib.plugin as plugin
from terminatorlib.terminator import Terminator
from gi.repository import Gtk, Gdk
import tempfile

AVAILABLE = ['OpenScrollback']

class OpenScrollback(plugin.Plugin):
    def __init__(self):
        # super().__init__(self)
        self.windows = Terminator().get_windows()
        for window in self.windows:
            window.connect('key-press-event', self.onKeyPress)

    # def onNewWindow(self):
    def onKeyPress(self, widget, event):
        if (event.state & Gdk.ModifierType.MOD1_MASK == Gdk.ModifierType.MOD1_MASK) and (event.keyval == 32): # Alt+Space
            # current_terminal = Terminator().get_focussed_terminal() # doesn't work for some reason
            current_terminal = Terminator().last_focused_term
            if current_terminal is None:
                print("No focused terminal!")
                return
            else:
                print("Found focused terminal!")
            current_window = current_terminal.get_toplevel()
            vte = current_terminal.get_vte()
            col, row = vte.get_cursor_position()
            content, _ = vte.get_text_range(0, 0, row, col, lambda *a: True)
            temp_file = tempfile.NamedTemporaryFile(delete=False)
            with open(temp_file.name, 'w') as f:
                f.write(content)
            tab = current_window.tab_new()
            new_terminal = current_window.get_focussed_terminal()
            command = " vim " + temp_file.name + '\n'
            new_terminal.vte.feed_child(str(command).encode("utf-8"))
