/*   Copyright 2018 Sergei Munovarov
 *
 *   Licensed under the Apache License, Version 2.0 (the "License");
 *   you may not use this file except in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *   limitations under the License.
 */

using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Graphics as Gfx;

class BaseMarketView extends Ui.View {

    hidden var ticker;
    hidden var current;
    hidden var size;

    hidden var priceLabel;
    hidden var volumeLabel;
    hidden var askLabel;
    hidden var bidLabel;

    function initialize(ticker, current, size) {
        View.initialize();
        self.ticker = ticker;
        self.current = current;
        self.size = size;
    }

    // Load your resources here
    function onLayout(dc) {
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
        View.onShow();
        priceLabel = Ui.loadResource(Rez.Strings.Price);
        volumeLabel = Ui.loadResource(Rez.Strings.Volume);
        askLabel = Ui.loadResource(Rez.Strings.Ask);
        bidLabel = Ui.loadResource(Rez.Strings.Bid);
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        var text;
        var justification = Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER;

        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        dc.clear();

        dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_BLACK);
        if (ticker == null) {
            text = "-:-";
        } else {
            text = ticker["pair"];
        }
        dc.drawText(dc.getWidth()/2, getPairOffset(), Gfx.FONT_TINY, text, justification);

        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        if (ticker == null) {
            text = formatText([priceLabel, "--"]);
        } else {
            text = formatText([priceLabel, ticker["last"].toFloat().format("%.02f")]);
        }
        dc.drawText(dc.getWidth()/2, dc.getHeight()/2 - getLastOffset(), Gfx.FONT_MEDIUM, text, justification);

        dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_BLACK);
        if (ticker == null) {
            text = formatText([volumeLabel, "--"]);
        } else {
            text = formatText([volumeLabel, ticker["volume"]]);
        }
        dc.drawText(dc.getWidth()/2, dc.getHeight()/2, Gfx.FONT_TINY, text, justification);

        dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_BLACK);
        if (ticker == null) {
            text = formatText([askLabel, "--"]);
        } else {
            text = formatText([askLabel, ticker["ask"].format("%.02f")]);
        }
        dc.drawText(dc.getWidth()/2, dc.getHeight()/2 + getAskOffset(), Gfx.FONT_TINY, text, justification);

        dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_BLACK);
        if (ticker == null) {
            text = formatText([bidLabel, "--"]);
        } else {
            text = formatText([bidLabel, ticker["bid"].format("%.02f")]);
        }
        dc.drawText(dc.getWidth()/2, dc.getHeight()/2 + getBidOffset(), Gfx.FONT_TINY, text , justification);

        dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_BLACK);
        if (current == null || size == null) {
            dc.drawText(dc.getWidth()/2, dc.getHeight() - getPositionOffset(), Gfx.FONT_XTINY, "-/-", justification);
        } else {
            dc.drawText(dc.getWidth()/2, dc.getHeight() - getPositionOffset(), Gfx.FONT_XTINY, current + "/" + size, justification);
        }
    }

    function formatText(args) {
        return Lang.format("$1$ $2$", args);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    function getPairOffset() {
        return 20;
    }

    function getLastOffset() {
        return 30;
    }

    function getAskOffset() {
        return 20;
    }

    function getBidOffset() {
        return 40;
    }

    function getPositionOffset() {
        return 20;
    }
}
