Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 14 Oct 2013 19:22:18 +0800
Message-ID: <3150890.WBi1sOLu6i@diderot>
In-Reply-To: <1381625420-4062-4-git-send-email-antonio@meshcoding.com>
References: <1381625420-4062-1-git-send-email-antonio@meshcoding.com>
 <1381625420-4062-4-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6583157.4nZBii5Z3e";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/4] batman-adv: improve the TT
	component to support runtime flag changes
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
Cc: Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart6583157.4nZBii5Z3e
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 13 October 2013 02:50:19 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> Some flags (i.e. the WIFI flag) may change after that the
> related client has already been announced. However it is
> useful to informa the rest of the network about this change.
> 
> Add a runtime-flag-switch detection mechanism and
> re-announce the related TT entry to advertise the new flag
> value.
> 
> This mechanism can be easily exploited by future flags that
> may need the same treatment.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  packet.h            |  6 ++++++
>  translation-table.c | 25 ++++++++++++++++++++++++-
>  2 files changed, 30 insertions(+), 1 deletion(-)

Applied in revision 5d07c1f.

Thanks,
Marek

--nextPart6583157.4nZBii5Z3e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSW9PyAAoJEFNVTo/uthzA9YEH/iNkhFCMgIJUx0zn8zflFFv4
9jvRzSYMM5w/OSCoavJdKtCyvUfghE5tbNRrNyVE1N1AaNvUSz6Oz4UGkDo0iGni
GmogLFzRJ8ZW54bNw/nM+K91hnUDvucb7F+iJ2GCgZ8p9D8y0iytgnUCQGTYGKbt
l4Iqtyi1jvWNYEJrBGWNhhuRmeHh4hjcjeaqebeJryT3P2JU/YT3bqjoii8qeGc/
F9kNRWw/6N72QJLI6/IVqx6BL/AdeslVGkm2S5dYmfVijbhwTemMJfRcz9Firj9g
iYAIjE1iB045GALC+ad8TaEdJFTCD2DPDizOcO1a7TWZRmLJhMzVaOy0bO5AmQ8=
=D587
-----END PGP SIGNATURE-----

--nextPart6583157.4nZBii5Z3e--

