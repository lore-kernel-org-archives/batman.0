Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH] batman-adv: Reserve needed_headroom for fragments
From: mephisto@mephis.to
Date: Thu, 26 Nov 2020 10:01:46 -0000
Message-ID: <20201126100146.1051.90640@diktynna.open-mesh.org>
In-Reply-To: <16FAA2FE-92FA-421E-9134-27AECE426F55@exaring.de>
References: <16FAA2FE-92FA-421E-9134-27AECE426F55@exaring.de>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

We currently observe that issue on our experimental VX-over-Wireguard Gateway, too. 

However, we had observed a similar performance hit about 2y ago  when introducing vxlan as layer below batman for wired mesh which might be related. We ignored it since debugging sessions were not conclusive for me as I'm no Kernelhacker and because it only applied to specific scenarios and vlan still outperformed the VPN connection.. still one similarity is that our debugging sessions also pointed to batman fragmentation that occured in conjunction with VXLan. Running pure batman over wire ran magnitudes faster.. Might be the same thing.

https://github.com/freifunk-gluon/gluon/issues/1315

In our current experimental setup when running vxlan over wireguard that performance hit hurts everyone..
