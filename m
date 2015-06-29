Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 29 Jun 2015 18:16:16 +0200
Message-ID: <43504885.6syhKky5ln@bentobox>
In-Reply-To: <55911414.90404@meshcoding.com>
References: <1434890572-3199-1-git-send-email-sven@narfation.org>
 <1434890572-3199-4-git-send-email-sven@narfation.org>
 <55911414.90404@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1650234.fN510GA2IV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 4/4] batman-adv: Fix gw_bandwidth
	calculation on 32 bit systems
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Marek Lindner <mareklindner@neomailbox.ch>


--nextPart1650234.fN510GA2IV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 29 June 2015 11:47:00 Antonio Quartulli wrote:
> 
> On 21/06/15 14:42, Sven Eckelmann wrote:
> > The TVLV for the gw_bandwidth stores everything as u32. But the
> > gw_bandwidth reads the signed long which limits the maximum value to
> > (2 ** 31 - 1) on systems with 4 byte long. Also the input value is always
> > converted from either Mibit/s or Kibit/s to 100Kibit/s. This reduces the
> > values even further when the user sets it via the default unit Kibit/s. It
> > may even cause an integer overflow and end up with a value the user never
> > intended.
> > 
> > Instead read the values as u64, check for possible overflows, do the unit
> > adjustments and then reduce the size to u32.
> > 
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > ---
> > v2:
> >  * rebased on current master
> 
> shouldn't this patch be for maint as it is also fixing a potential
> overflow issue?

Only the configuration for users is not correctly stored. For example 
4294967296Mbit would result in 0.1 Mbit instead of showing a failure. This is 
hopefully not the biggest problem.

Just tell me if you want it resubmitted against maint (Linux 4.1.x).

Kind regards,
	Sven
--nextPart1650234.fN510GA2IV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVkW9UAAoJEF2HCgfBJntGLwIQAJOmo7WLqkdsUTL7NTp75juR
hzpXMg4Z+41bq9lcqAZ9LcX4F7Yvp3QS4DNlin27ekFyph7X3DFGDKCoK3x/kow2
7UqueuSupqrdlDtdzrgl7VTqCO7zfJW5aPITfN+W/v+RPdM3mmcNStA5elu/dSgK
qy1dCUQLdREgu3jYoj5PzNXirzaYVwchLrZJci2e4lys5Gt9HQU4jpODQbBHo+NH
mBe5OF4PMm33SaiLS9YMiVwpIp+i4HEWBdUSXf7y3MMHkFSVZeGJmtHRkF9+8JZI
DFmYxgCWtwt8y3YTU9wM530wVjzK4/rTN6y95rRNFgb0Zd4MzxYuFuTLjY2VnlaR
5f9Fzf3ejzf737oslNLxJlP63YtViUK0o8u1UGqAXSQh+6OIlLR+xjcx6KkQwnbR
UgT4aMzydmwj2CRFB9nuq4oJQA8g+vLicCBVvw6vkWOXNFgldd1ZXRTnmZ7elhRj
bLSlkpqg//qYUsIsuu1cJHN7UCJ27umfVPxA4QJXoF3lgACqem8KEs2KENaDNQBp
G0vNoeBrvd871RuOyvl417VsEoJMmqxjT3fq9YSTJU5QMsoQ2YZpjSQWgY5i3YiR
qocmkm5KBm3jmOVpK0rSkZKwpfoysihhwioDm/uOwvDwtOUkpeQOcu032+9JCVCR
eioAWFgjrF+ONyqcsKWj
=9cvM
-----END PGP SIGNATURE-----

--nextPart1650234.fN510GA2IV--

