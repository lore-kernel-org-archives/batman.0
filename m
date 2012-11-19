Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 19 Nov 2012 20:29:07 +0100
Message-ID: <5268262.CIrZ93ERtB@bentobox>
In-Reply-To: <1353351150.4156.4.camel@bwh-desktop.uk.solarflarecom.com>
References: <1353313451-2930-1-git-send-email-ordex@autistici.org>
 <1353313451-2930-5-git-send-email-ordex@autistici.org>
 <1353351150.4156.4.camel@bwh-desktop.uk.solarflarecom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6508802.VGmHYGSYs7";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 04/10] batman-adv: export compatibility
	version via debugfs
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
Cc: Ben Hutchings <bhutchings@solarflare.com>, netdev@vger.kernel.org, Marek Lindner <lindner_marek@yahoo.de>, davem@davemloft.net


--nextPart6508802.VGmHYGSYs7
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 19 November 2012 18:52:30 Ben Hutchings wrote:
> On Mon, 2012-11-19 at 09:24 +0100, Antonio Quartulli wrote:
> > Different versions of the batman-adv module may use the same compatibility
> > version, but this is not understandable at runtime (the only way is to
> > parse the kernel log and fetch the batman-adv advertisement message on
> > loading). The user may want to know whether two nodes using different
> > versions can communicate or not. For this purpose the module has to
> > export this value through debugfs.
> [...]
> 
> I do hope that you're not planning to use unstable debugfs interfaces
> indefinitely.

Why are you refering to the adding of an file as "incompatible" debugfs 
interface? I would call it additional information. And the rest of the commit 
message is talking about *possible* protocol incompatibilies of the network 
protocol (which caused this uncontrolled erruption of anger in a network 
maintainer).

Kind regards,
	Sven
--nextPart6508802.VGmHYGSYs7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQqoiDAAoJEF2HCgfBJntG9KoP/ijqUPa/sKIKOajMLSMl9Z9i
IRuwe3FLT3CMy1Eei+e6f9nGlYvYaT3YV9j355PnDWneY+CPP09qNWYet2znbnwL
B50/SRYzvV0CAWs3bjczSZXtPvaIe43gEYSkgSdwd3XBWnkkicY/A3J4JxGwtUhL
TvocJK7XpAOyOj0ESFzactfGYZhs4c0WkcHM4pvWoMVdAFAO2PvmUkOzTZCHVoU1
Z0TjKbZzMzJRFJjtfQqdb2nijeaXzzWlQ419KEfYPmfqjLE2skBkSS3rMRB0ha82
7z+CCJbrnFjsAu3MMzpQbIh3/mPgVvBd4hW+x1+QmJ93JIpy8eeP1cHd0Hh/kh4p
2V5t3FWOofPNSqMd9lsKrNaquMbDnIqCOrCychgCdigxY59UPeOTjLAfpU9MUZSt
eFCJCTcJw4cJ/jbKjvVhjcTq3WCcWAkkXS3vNUh6UOmhGwssFQKEpAGN9PTZ+rlo
RCOAVcrDVruIWeuNOhQcGBfAT+aElnVWP13M4IYojA1fiqJkSOlR9w6bKxkm5UXc
AwuGc8iljhXexsHQ4EZClKN1Y3+Rj3u/OjqIcq2NvGibAy0CR6YQIj6qOdLQKLuz
O5AkEX2mIkaaaC+uQOHV6zBvU0sbl4Tx+DrHFfpAtcGiD5GeA995TMSqzJgbzV97
gsUve5iX+1+l0GVCQhiz
=BNJk
-----END PGP SIGNATURE-----

--nextPart6508802.VGmHYGSYs7--

