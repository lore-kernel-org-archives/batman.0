Return-Path: <michael.holcman1@free.fr>
Date: Sun, 15 Jun 2014 15:49:35 +0200 (CEST)
From: michael.holcman1@free.fr
Message-ID: <1923128878.64697034.1402840175117.JavaMail.root@spooler5n-g27.priv.proxad.net>
In-Reply-To: <1373110972.64674916.1402839263349.JavaMail.root@spooler5n-g27.priv.proxad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] question about batman-adv auto run
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
Cc: martin@hundeboll.net

Hello,
Do you know how to auto run batman-adv, because, i have no answer where i write:/etc/init.d enable ?

Where i can located the configure fils as following ?


config 'mesh' 'bat0'
	option 'interface' 'wlan0' 'bride'
	option 'aggregated_ogms'
	option 'ap_isolation'
	option 'bonding'
	option 'fragmentation'
	option 'gw_bandwidth'
	option 'gw_mode'
	option 'gw_sel_class'
	option 'log_level' 'all'
	option 'orig_interval' '500'
	option 'vis_mode'
	option 'bridge_loop_avoidance' '1'
	option 'distributed_arp_table'
	option 'network_coding'
	option 'hop_penalty'

# yet another batX instance
# config 'mesh' 'bat5'
#	option 'interfaces' 'second_mesh'
