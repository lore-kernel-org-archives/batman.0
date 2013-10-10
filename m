Return-Path: <bittorf@bluebottle.com>
Date: Thu, 10 Oct 2013 10:36:18 +0200
From: Bastian Bittorf <bittorf@bluebottle.com>
Message-ID: <20131010083618.GQ8785@medion.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] batman / iptables / changed mac
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

we see a strange behaviour using OpenWrt r38277
with kernel 3.10.14 and batman-adv: 2013.3.0

we use a http-splash-page, where the laptop's must
click 'ok'. the iptables-rules are working like this,
when the button is pressed:

iptables -t mangle -I PREROUTING -d $laptop_ip -j ACCEPT
iptables -t mangle -I PREROUTING -m mac --mac-source $laptop_mac -j ACCEPT

we had the effect, that laptop can press the button and
the rules are active, but 'internet was not working'.

looking deeper into this, we can see that the second rule (mac)
was not used, so the laptop gets the splash-page again and again.

via using:

iptables -t mangle -I PREROUTING -s $laptop_ip -j LOG

we can see, that the mac-adress which the kernel/iptables sees is not
the one from the laptop, the log-entry looks like this:
(IP 192.168.99.243 = Laptop)

[ 2579.600000] from_192.168.99.243: IN=eth0.1 OUT=
MAC=02:00:ca:b1:00:99:02:00:de:ad:00:02:08:00:45:00:00:3c
SRC=192.168.99.243 DST=193.99.144.80 LEN=60 TOS=0x00 PREC=0x00 TTL=62
ID=43918 DF PROTO=TCP SPT=55132 DPT=80 WINDOW=14600 RES=0x00 SYN URGP=0

the mac seems strange, the real mac is '00:13:e8:82:7e:4b'.
but the pattern is interesting:

MAC=02:00:ca:b1:00:99:02:00:de:ad:00:02:08:00:45:00:00:3c

the mac consists of 3 macs somehow:
02:00:ca:b1:00:99
02:00:de:ad:00:02
08:00:45:00:00:3c

the first is the 'lan1/cable' mac of the router which does the splash
the second is the 'lan2/cable' mac of the nexthop router. the last one:
* i have no idea *.

i can reproduce the issue, so i can deliver much more debug-output than
this. any idea with this data yet? for now we mac a 3rd rule, like the
log-rule to 'free' the laptop - but i call it a workaround.

iptables -t mangle -I PREROUTING -s $laptop_ip -j ACCEPT

bye, bastian

