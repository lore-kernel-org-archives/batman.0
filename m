Return-Path: <carlosmeralto@gmail.com>
MIME-Version: 1.0
Date: Wed, 17 Jun 2015 20:50:26 +0100
Message-ID: <CALaFpeXinpuqi_5tZoih9jm77Ed0WsP_soZm3RbTpOmpzqWPSg@mail.gmail.com>
From: Carlos Meralto <carlosmeralto@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] [BATMAN] batman-adv PING layer 3
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hello everyone.

I have three mesh nodes. Node A don=E2=80=99t see node C. A can't communica=
te
with C directly, but it can commuticate with C via node B, which is
between A and C. The path is A - B - C.

On node A, I can run the command 'batctl ping MAC' to node B and node
C successfully.
When i try the normal layer 3 ping [ping IP] it=E2=80=99s ok to node B for
node C doesn't work.
Maybe i have a wrong configuration at layer 3.

My configurations:

/etc/config/network

config interface 'lan'
        option ifname 'eth0.1'
        option type 'bridge'
        option proto 'static'
        option ipaddr '192.168.0.1'
        option netmask =E2=80=98255.255.255.0'

config interface 'mesh'
        option ifname 'adhoc0'
        option mtu '1528'
        option proto 'static'
        option mesh 'bat0'
        option ipaddr '192.168.11.1'
        option netmask =E2=80=98255.255.255.0'

/etc/config/wireless

config wifi-iface
        option device 'radio0'
        option ifname 'adhoc0'
        option network 'mesh'
        option mode 'adhoc'
        option ssid 'batman-mesh'
        option encryption 'none'
        option bssid '02:CA:FE:CA:CA:40=E2=80=99

/etc/config/batman-adv

config mesh 'bat0'
        option interfaces 'adhoc0'
        option 'aggregated_ogms'
        option =E2=80=98ap_isolation'
    [..]


root@OpenWrt:~# batctl if
adhoc0: active

the difference between nodes is the ip address for interface
lan(192.168.0.1, 192.168.2.1, 192.168.3.1) and mesh (192.168.11.1,
192.168.11.2, 192.168.11.3)

What i need to setup to can ping from node A to C?

Best Regards.
