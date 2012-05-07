Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 07 May 2012 08:43:06 +0200
Message-ID: <7772207.d3Er5W7jJA@bentobox>
In-Reply-To: <4FA75113.40401@universe-factory.net>
References: <4FA54C09.6000303@universe-factory.net>
	<20120506201435.GA27416@pandem0nium>
	<4FA75113.40401@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12151442.Zx8u59hZvt";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: fix visualization output
	without neighbors on the primary interface
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart12151442.Zx8u59hZvt
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, May 07, 2012 06:35:31 AM Matthias Schiffer wrote:
[....]
> I have some questions about the code though:
> 
> - Is there any reason vis_seq_print_text() allocates a buffer at all instead
> of just printing the data directy into the seq_file? Looking at the
> seq_printf implementation, there doesn't seem to be a problem calling it
> while holding the lock.

This is something which came from an old... old... old implementation. It 
didn't use debugfs and seq_printf and therefore stupid tricks had to be used. 
Actually, the current implementation is broken and has to be changed (but no 
one wanted to touch the vis code).

> - In many places in the vis code
> hlist_for_each_entry_rcu() is used to iterate over the hash lists, even
> though all access to vis_hash is guarded by the vis_hash_lock, so it seems
> to be okay to just use hlist_for_each_entry(). In some functions,
> vis_seq_print_text() being one of them, rcu_read_lock/unlock pairs could be
> removed as well with this change. Do I overlook something?

I think it would be better to reduce the spin-locking and change the code to 
use rcu_read_lock. But maybe we have to think a lot about the data structures 
to generate consistent output... so maybe it is not possible (when also 
wanting it implemented in an efficient way).

Kind regards,
	Sven
--nextPart12151442.Zx8u59hZvt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJPp276AAoJEF2HCgfBJntG4SYQAMt6xDn5VL9GUGaMgNzbrvQp
B2+0QcfdFPQAoqg+q0CfBgCB1XE7rvhhDKlHd1/wrx6rJNz0m9RA0kQ+JlJKJXJz
G5rgOTaZNw5ZqRpGXxrtFs0Z16qFsbF5Tfv52r9PKBbkoH7tyaFFxKJ7uIQkgSgl
1BML7/FXYU8WJI5Z8/5p8oowSXwqPq6ej+yHZr26hBiLzm1Qf0lyG96tlGzJJiu7
GkiWjlroi70j4pbOJiSOTt2/dK0vMYNTtKCuvxqY++gSekzf3PuyWXobfJT3+HLn
XLzBki5XD/VJbtdt4xa8J7+eQsU5r68V8fZiVKH3fxnVReWMp4dLwiWG+4aUy0O1
RDjsgg8kBDWi8dqw07QzR43w0zgoox0Ju6z5HpgiB1P35z1n+o4r8waBU4VybzHM
uhDOK560pyuLM5jfLQ3t3piChZv+ZZ4fvr6CeYLrFHRjhJ6656QU1dCmeLbXQcfx
V2qZy0oRMr1GPPFNz650LgUVu6cMPmY9udvBnfMm+Flge93ZkDIrn1F8j96S5aP1
nCXkKcaC3Rk4QQTjaVka14qRDt9yO3DRSJQWx0JpsTTzZlWqHiE3NYbvop3sA9DN
KUa6/iGpDFJxgphPo/dU5aovTuI3HbfDUg1Ydaw8FQn1bgHlut+Mor3QS2UpFrOA
Na/iKm4oTQpZ9utR+bGQ
=quqV
-----END PGP SIGNATURE-----

--nextPart12151442.Zx8u59hZvt--

