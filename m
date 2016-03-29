Return-Path: <are@lihas.de>
Date: Tue, 29 Mar 2016 10:37:17 +0200
From: Adrian Reyer <are@lihas.de>
Message-ID: <20160329083717.GA32035@r2d2.s.lihas.de>
References: <56F5AF2F.6060904@t-online.de> <6005839.o5jWIFZeG0@voltaire>
 <56F934F9.5000508@t-online.de> <11401348.Kx9RpUz81r@voltaire>
 <20160328191128.GA2772@otheros> <56F99FCD.5040704@t-online.de>
 <20160328235247.GA4528@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160328235247.GA4528@otheros>
Subject: Re: [B.A.T.M.A.N.] No rebroadcast on mesh links
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi,

On Tue, Mar 29, 2016 at 01:52:47AM +0200, Linus Lüssing wrote:
> At least this approach would cover everything we care about for
> current Freifunk setups for now and many more. Without the user
> being able to misconfigure something that easily. (usually a user
> would not set a TRANSITIVE flag on the interface, but e.g. drivers
> and applications creating the interface would)

The interface doesn't have the information needed, so the (assumed) huge
effort of bringing in a new flag for all types of network interfaces is
somewhat useless.
In my eyes we have two types to consider here:
1. lossy links, this is what can be 'fixed' be repeatedly sending a
broadcast out
2. different listeners, e.g. due to wifi range. If we have the same
listeners for everyone on an interface we don't need a re-broadcast at
all.
There are many different possibilities to generate the different
combinations of 1 and 2 with common hardware.
- wifi AP-mode: lossy, same listener
- wifi adhoc mode: lossy, different listeners
- ethernet cable on a switch with the listeners on: non-lossy, same
  listeners
- ethernet cable towards a wifi-bridge in adhoc mode
- ethernet cable towards a wifi-bridge in ap mode
- various types of vpn with and without meshing
- SoC with wifi attached via vlan in adhoc, station or ap mode
- network technologies stacked on others, e.g. tagged vlan a into
  openvSwitch and the lossy wifi link is the untagged vlan a, while
  tagged vlan b is plugged into a solid vpn.
- add bridges to the game, old style or ovs
- add other stuff like ppp, slip, atm, ...
I advocate an admin-settable flag for batman, defaulting to the current
behaviour. Nothing breaks that way, only batman needs to be adjusted and
the patch already exists and is tested. Admins can set the flag if they
think they have use for it and they do it knowingly. If they do it 'by
accident' it is as little batmans fault as if they earased their disk
with some dd-command. Default is sane, just more traffic than necessary
in some common szenarios.
Even if someone decided that flag would not be needed anymore in some
near or far future and therefore it is decided to remove it, only those
that wanted to use it get an error message, it is still a functional
system. However, I seriously doubt there is a good alternative to
manually setting that flag within batman in the forseeable future.

Best regards,
	    Adrian
-- 
LiHAS - Adrian Reyer - Hessenwiesenstraße 10 - D-70565 Stuttgart
Fon: +49 (7 11) 78 28 50 90 - Fax:  +49 (7 11) 78 28 50 91
Mail: lihas@lihas.de - Web: http://lihas.de
Linux, Netzwerke, Consulting & Support - USt-ID: DE 227 816 626 Stuttgart
