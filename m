Date: Sun, 22 Aug 2021 14:23:14 +0530
From: Pranav Jerry <libreinator@disroot.org>
Subject: Python script to setup batman networks
Message-Id: <QOG8YQ.NVVN3QKSHSCP2@disroot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi!

I have made a python script [1] to setup batman-adv networks using
systemd-networkd. It requires iwd and systemd-networkd v248 or above.

It starts an adhoc network on wlan0 (or any other wireless interface)
and adds it to bat0. To allow non-mesh clients to connect to
the mesh, if there are two WiFi adapters, the script starts an
AP on one of the adapters.

The script is supposed to be run as a systemd service, since
it can ensure that the dependencies are started before it is run.
The network is configured with systemd-networkd runtime configs
(since it has not implemented configuration via D-Bus)
and the iwd D-Bus API.

All suggestions, criticism and contributions are welcome.

[1]: https://git.disroot.org/pranav/naxalnet


