Return-Path: <sprudent@osmozis.com>
From: Sylvain PRUDENT <sprudent@osmozis.com>
Message-ID: <06c85527-ec8d-bead-ca65-2736cba8507f@osmozis.com>
Date: Thu, 20 Dec 2018 11:09:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] gw_mode & vlan
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

Hello again,

I am using batman to set up a big lan network that allows clients to 
roam between the different APs.
The mesh network is also carrying private vlan that have dedicated dhcp 
servers outside of the mesh network.
A lot of clients may connect to the lan so I would like to use gateway 
mode (client/server) feature to avoid dhcp broadcast storms.
Is it possible to use gw_mode for the main lan network without affecting 
dhcp traffic on the private vlan networks ?
I already checked that the setting is not usable in the vlan scope.
Right now, my test setup is composed of qemu vm bridged together running 
vanilla openwrt-18.06.1-x86-64-combined-ext4.img (batman-adv: 2018.1).

regards,
sprudent


