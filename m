Return-Path: <dominicfollett@gmail.com>
MIME-Version: 1.0
Date: Sat, 22 Sep 2012 18:06:22 +0200
Message-ID: <CA+h5Vgp5Pwjn0tVnC1bWg=R8tXdwxskesgtt2uTuwdSDtaNzDg@mail.gmail.com>
From: Dominic Follett-Smith <dominicfollett@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] running batmand on Debian for Alix
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

Hi,

I am having trouble running the batman protocol on my debian distro
(2.6.32) on PC Engine's Alix boards. I am using CM9 pci cards, with
ath5k driver from the compat-wireless-3.5 package. I can scan for
networks, and view a survey dump using the iw tool. despite being able
to start the daemon successfully, neither node can receive packets
from one another. I set the mode to ad-hoc and channel to channel 7 on
both alix boards. The following url is a link to my system profile on
pastebin:

http://pastebin.com/RtpTe31C

it includes (ifconfig, iwconfig, interfaces configuration, sample of
running batman, dmesg for wireless interface wlan0 and modinfo for
ath5k )

I can't figure out what I am doing wrong, I had perhaps naively
assumed that passing a configured wireless interface would be enough,
but I guess I have missed something important.

Help is always greatly appreciated.

Thanks
Dominic
UCT, SA

--
If you are going to achieve excellence in big things, you develop the
habit in little matters. Excellence is not an exception, it is a
prevailing attitude.
Colin Powell
