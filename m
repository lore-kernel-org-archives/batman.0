From: "Lui" <batman@schmudde.com>
References: <00e801c73614$8a5c5060$0105a8c0@bluebox>
Date: Sat, 31 Mar 2007 06:49:10 +0200
Message-ID: <004a01c7734f$ed211f50$fe78a8c0@bluebox>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
In-Reply-To: <00e801c73614$8a5c5060$0105a8c0@bluebox>
Subject: [B.A.T.M.A.N.] Relaese: freifunk-batman_0.83.ipk
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: "'B.A.T.M.A.N.-ML'" <b.a.t.m.a.n@open-mesh.net>

Hi,

freifunk-batman_0.83.ipk is out now.

hope it's usefull
Lui

CHANGES:
# ----------------------------------------------------------------------------

ToDo:
* Info: better representation of status and link-relations...
* Translations: it-fr-nl-<place your language here>
* Config: 'choosing' a prefered gateway
* ...
* keep close to the hight development-cycles of batmand ;-)
* watching out for B.A.T.M.A.N.-IV ;-)

Changes (0.82 -> 0.83)
+ "Raider is Twix" and S55batman is S66batman now - lowers a timestamp problem with S60rdate
+ removed S54(/S65)robin

Changes (0.81 -> 0.82)
+ replaced option d|debug with log... (S55batman log <mode> <time>)
+ fixed cron entry + added tun-ex
+ added: S55... v like batmand -v

Changes (0.80 -> 0.81)
+ use /etc/ff_bat.config and remove extensive use of nvram (/-commit)
+ language *switch* via config...
+ layout issues

Changes (0.7x -> 0.80)
+ (merged) support for non-WRT like hardware (i.e SE505) and tagged-vlans...
+ community network support: choose olsr->batman network (/8 /16 /24) transition.
+ multi language support: de, en (please help with your addional translations)
+ status-page with links to known nodes
+ B.A.T.M.A.N.-III v0.2++ client-mode info on router-frontpage
+ S55batman initscript opens by default traceroute ports
+ re-designed bad handling of NVRAM-vars
# ----------------------------------------------------------------------------

...this last informations are still valid:

>Sent: Freitag, 12. Januar 2007 07:40
>To: B.A.T.M.A.N.-ML
>Subject: [B.A.T.M.A.N.] freifunk-batman-de (0.73 "vampimated")
>
>Hi all,
>
>cleanups - and more... ;-)
>
>!!!Important!!!
>For those of you, who have installed any previous versions - 1st:
>#>ipkg remove freifunk-batman-de
>
>For others:
>freifunk-batman-de is a WebUI-Plugin for the freifunk-firmware (->[1])
>It allows to easily configure and manage all aspects of the 
>batman-daemon in a side-by-side environment with olsr (even 
>for unskilled users).
>[...]
>The main goal is to raise the amount of 
>batman-nodes in 'a mesh' of heterogeneous skilled node owners 
>over 'the critical-mass' in the phase of development and 
>testing... and of course, to make it easy for myself to manage 
>testing with 10++ batman-nodes.
>
>[...]
>
>Find it at: http://freifunk.schmudde.com/ipkg
>
>Regards
>Lui
>
>[1] - http://ff-firmware.sourceforge.net/

