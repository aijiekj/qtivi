/****************************************************************************
**
** Copyright (C) 2016 Pelagicore AG
** Contact: https://www.qt.io/licensing/
**
** This file is part of the QtIvi module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD-QTAS$
** Commercial License Usage
** Licensees holding valid commercial Qt Automotive Suite licenses may use
** this file in accordance with the commercial license agreement provided
** with the Software or, alternatively, in accordance with the terms
** contained in a written agreement between you and The Qt Company.  For
** licensing terms and conditions see https://www.qt.io/terms-conditions.
** For further information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
** SPDX-License-Identifier: BSD-3-Clause
**
****************************************************************************/

import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2

import QtIvi.VehicleFunctions 1.0

GroupBox {
    property WindowControl zone

    function stateToString(state) {
        if (state === WindowControl.FullyOpen)
            return "Fully Open";
        else if (state === WindowControl.Open)
            return "Open";
        else
            return "Closed";
    }

    ColumnLayout {
        RowLayout {

            enabled: zone.state.available
            Label {
                text: "Window state: "
            }

            Label {
                text: stateToString(zone.state.value)
            }
        }

        Button {
            text: "open"
            enabled: zone.state.available
            onClicked: zone.open()
        }

        Button {
            text: "close"
            enabled: zone.state.available
            onClicked: zone.close()
        }

        RowLayout {
            GroupBox {
                title: "Window blind"

                ColumnLayout {
                    RowLayout {
                        enabled: zone.blindState.available

                        Label {
                            text: "State: "
                        }

                        Label {
                            text: stateToString(zone.blindState.value)
                        }
                    }

                    ExclusiveGroup {
                        id: blindGroup
                    }

                    RadioButton {
                        text: "Open"
                        exclusiveGroup: blindGroup
                        enabled: zone.blindMode.availableValues.indexOf(WindowControl.BlindOpen) !== -1
                        checked: zone.blindMode.value === WindowControl.BlindOpen
                        onCheckedChanged: {
                            if (checked)
                                zone.blindMode.value = WindowControl.BlindOpen
                        }
                    }

                    RadioButton {
                        text: "Closed"
                        exclusiveGroup: blindGroup
                        enabled: zone.blindMode.availableValues.indexOf(WindowControl.BlindClosed) !== -1
                        checked: zone.blindMode.value === WindowControl.BlindClosed
                        onCheckedChanged: {
                            if (checked)
                                zone.blindMode.value = WindowControl.BlindClosed
                        }
                    }

                    RadioButton {
                        text: "Automatic"
                        exclusiveGroup: blindGroup
                        enabled: zone.blindMode.availableValues.indexOf(WindowControl.AutoBlind) !== -1
                        checked: zone.blindMode.value === WindowControl.AutoBlind
                        onCheckedChanged: {
                            if (checked)
                                zone.blindMode.value = WindowControl.AutoBlind
                        }
                    }
                }
            }

            GroupBox {
                title: "Heater"

                ColumnLayout {

                    RowLayout {
                        enabled: zone.heater.available

                        Label {
                            text: "Running: "
                        }

                        Label {
                            text: zone.heater.value
                        }
                    }

                    ExclusiveGroup {
                        id: heaterGroup
                    }

                    RadioButton {
                        text: "On"
                        exclusiveGroup: heaterGroup
                        enabled: zone.heaterMode.availableValues.indexOf(WindowControl.HeaterOn) !== -1
                        checked: zone.heaterMode.value === WindowControl.HeaterOn
                        onCheckedChanged: {
                            if (checked)
                                zone.heaterMode.value = WindowControl.HeaterOn
                        }
                    }

                    RadioButton {
                        text: "Off"
                        exclusiveGroup: heaterGroup
                        enabled: zone.heaterMode.availableValues.indexOf(WindowControl.HeaterOff) !== -1
                        checked: zone.heaterMode.value === WindowControl.HeaterOff
                        onCheckedChanged: {
                            if (checked)
                                zone.heaterMode.value = WindowControl.HeaterOff
                        }
                    }

                    RadioButton {
                        text: "Automatic"
                        exclusiveGroup: heaterGroup
                        enabled: zone.heaterMode.availableValues.indexOf(WindowControl.AutoHeater) !== -1
                        checked: zone.heaterMode.value === WindowControl.AutoHeater
                        onCheckedChanged: {
                            if (checked)
                                zone.heaterMode.value = WindowControl.AutoHeater
                        }
                    }
                }
            }
        }
    }
}
