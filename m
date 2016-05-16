Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 16 May 2016 20:58:13 +0200
Message-ID: <33261549.crZoJBqqoP@sven-edge>
In-Reply-To: <1463419689-3580-1-git-send-email-andrew@lunn.ch>
References: <1463419689-3580-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9035376.iVMeF0bajg";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v6 00/11] netns and netlink support
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
Cc: Antonio Quartulli <a@unstable.cc>, mareklindner@neomailbox.ch

--nextPart9035376.iVMeF0bajg
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 16 May 2016 19:27:58 Andrew Lunn wrote:
> * No change to code indentation. I consider it a false positive. The
>   code is more readable the way it is, checkpatch is happy, and it
>   does not violate anything in CodingStyle, as far as i can see.

@Antonio, @Marek, @Simon: Do you want to allow free-form alignments like this?

			if (batadv_iv_ogm_neigh_dump_hardif(
				    msg, portid, cb->nlh->nlmsg_seq,
				    bat_priv, hard_iface, &idx)) {
				i_hardif--;
				break;
			}

I just know that this strict form was requested [1] (enforced!!!) by the
Linux net maintainer David Miller (and some other people but I just link
this because the discussion got really "juicy").

And to your "no change to code indentation". There is definitely one in your
latest patchset. It introduces a new free-form alignment to
batadv_iv_ogm_neigh_dump

		if (i_hardif_s == 0) {
			if (batadv_iv_ogm_neigh_dump_hardif(
				    msg, portid, cb->nlh->nlmsg_seq,
				    bat_priv, single_hardif, &idx) == 0)
				i_hardif++;
		}

Kind regards,
	Sven

[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2011-December/005932.html
--nextPart9035376.iVMeF0bajg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXOhhFAAoJEF2HCgfBJntGXVMP+wX3Spj4eiMfGwz2IBxeb7TJ
drpZDTIp3I3PU0igG7IElwaSvFyLunxGDdZfjVk5ly3R6W6KvaS/VXzSvZpaD70w
WhI5tbixgyyYJwZCXGm0jRxL8HMZSS+xKYDDTIUIhYTf69A9IIQGEX8WnUEZaWeQ
5cQg+DrLnX/l3r5zeIgXNGi3S0WdGhOP6FKjexVeCQ2rs59EhfRvR1UIxvrUSDta
XbuCLuBv6/ZMkwjY9t5i4VEtN0HfTBzq++F6qxoBuDjQ2INaUCnb5EnJAgzzfVNE
AVv47hM1dQFUbHT4jNDqh3IxzPPGbWd580/xz0trKl8C7V1/HP/Yhc1/TNJiup+i
df7Wfb1xFozcwmkPC+kjL2QhyhaDJLJP1vn03D/XbK2irVx6Gu63acxsXX/SzTuF
KxKspUWdvdrxeWHj3ZhhWieDuvB2+v8TEL3pLXOijGpeogix3PeZhjEhzMD1C+x3
f9RYcIjqbjP8KC8XUdWN1d40N22dhu8uIe7XwQx3CrIDMatpppj9QqIc7Ow2XIo+
KfT4nY9X/W6UjTm5U6/r8ELQXrxbgjuIEbiXGmyVOVYB6IIMY31TXIf4I951zhyq
GNJLCX4wM4THT4rU3qlEjF1P2T3wQWYuRK4EZAlz0ugb5iz85lSVSbX4+Dqa2hr1
j02kmafAN4SqWsV6XbRs
=9VaB
-----END PGP SIGNATURE-----

--nextPart9035376.iVMeF0bajg--

