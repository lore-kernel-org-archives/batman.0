Return-Path: <tobias@hachmer.de>
Message-ID: <53D6930B.8090704@hachmer.de>
Date: Mon, 28 Jul 2014 20:14:35 +0200
From: Tobias Hachmer <tobias@hachmer.de>
MIME-Version: 1.0
References: <1406281919-25318-1-git-send-email-sven@narfation.org>
 <201407281334.23985.sw@simonwunderlich.de>
In-Reply-To: <201407281334.23985.sw@simonwunderlich.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Make unix socket path
	configurable
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hello,

On 07/28/2014 01:34 PM, Simon Wunderlich wrote:
> Applied in revision 6c6a6f7.

Thanks so much for pushing this patch upstream! Just tested here on a
ubuntu machine. Using the new command line option works fine, but I
can't run another instance:

root      9063     1  0 19:55 ?        00:00:00 /usr/sbin/alfred -i
mzBR -b mzBAT -u /var/run/alfred-mz.sock -m

netstat | ss - output:
udp6       0      0 :::16962                :::*
          0          66467       9063/alfred
UNCONN     0      0                        :::16962
:::*      users:(("alfred",9063,4)) ino:66467 sk:ffff88003bf0b300 <->

Error output after starting a second instance like "/usr/sbin/alfred
- -i wiBR -b wiBAT -u /var/run/alfred-wi.sock -m":

- ---
can't bind
- ---

What is the upd6 socket for? Is this the link-local multicast one?

- ---:~# netstat -g | grep mzBR | grep ff02
mzBR            2      ff02::1:ff00:0
mzBR            1      ff02::1:ff25:17
mzBR            1      ff02::1:ff6d:7aec

Any help appreciated.

Regards,
Tobias Hachmer
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCgAGBQJT1pMLAAoJEHXGlTiIv2V4k7oQAJ3FZtgCyX3qsTVQWfYUOk2+
2KxezBOvIiP5+Xqy24zQ1CfHDXj/anMaXilleOAmXC8R60Sh1NSREXYfIqNqiknQ
v+s6gznZ5Wg9yfKYpwWLSsi4KFzRG4tCSa0+Hqr9I3HRy/3xwkAib8XLYJJMXPC7
RlWHFLn5Q9gxNbsJx+1JQVRzxDF+C7lGXI4tmyL9dIEMU0tPjlKUaw5yr2ZNEad1
BfcbzyplnTo5y1J3D2BfHNIZlruz4IqTDa1oIfbx9t/WzF3w8LYqLi6H6vdqJZ5T
9PPqTczGn/xyR01j7CQnU0WtlWsFdQr/gc4/NQcMxggSWpmEa+ZGwxR4hnXowDz+
jad7y9Cz8IqbrJ9WXKNeQ+9IiIf0MSi9hiY04d1m0/U3bswecGQsHiSWzlUVPC5c
Ke6g2HHMYASNkC/DuKdPI4uA4eeBuVpNT/aT4V3KBWG2Ls2ssnbv+/sTQxGO7Moo
51JF1j15HYdqyfB/E9f4wA1QAwbIMDsAgJIQ34Z9owDMUCMUWWVt01XvBc+UnSSS
X+l3qy7iGAWes3Cif/vP+Kvn4hXh2D4RAyrWl9p9G4rbxxA6SjTu64+ZDPuJpall
9NW+YjgL49ZrX6yxl/OPxV+BY8EN5aM2vuunKL8kCKloaKfCBZXOoHVrkLf+aTCY
yoXk7v9YZPWWJlVcmXE4
=gk4U
-----END PGP SIGNATURE-----
