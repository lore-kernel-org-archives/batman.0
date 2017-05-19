Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 19 May 2017 09:07:04 +0200
Message-ID: <1661470.hcNBASnkvL@bentobox>
In-Reply-To: <OFE5F92E4D.60A86F64-ONC1258125.00232B05-C1258125.0023A966@phoenixcontact.com>
References: <OFE5F92E4D.60A86F64-ONC1258125.00232B05-C1258125.0023A966@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1623673.fgYYGVVioI";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Memory leakage
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

--nextPart1623673.fgYYGVVioI
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 19. Mai 2017 08:29:29 CEST Andreas Pape wrote:
[...]
> I think the line with the "return NET_RX_DROP;" needs to be replaced by
> "goto skb_free;".

Yes

> How is the correct procedure to change this? As this patch has already
> been committed to
> the git repo I guess I should send a new patch or is a new version of the
> old patch necessary?

Thanks for debugging this. Please sent a new patch based on master [1] and add 
following line above your Signed-off-by

    Fixes: bfe2a1971f43 ("batman-adv: drop unicast packets from other backbone gw")

We will take care of submitting it to Linux net for Linux 4.12. If you still
have problems with your IT department then you can either send the patch from 
a private mail account (git-send-email will then add an extra "From:" line to 
keep your phoenixcontact.com mail address as author mail address) or (if not
otherwise possible) sent it again as attachment to me or Simon. We can then
forward it to the mailing list.

Kind regards,
	Sven

[1] Your patch is currently only in master. It should actually be in maint but
    Simon hadn't found the time to release master as 2017.1. Which is not to
    bad because now we can still incorporate your fix.
    It would be different when the patch would already be part of maint. Then
    it would be better when you should create your patch on top of maint
--nextPart1623673.fgYYGVVioI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlkemZgACgkQXYcKB8Em
e0btug//YVtgY9jE8Bx0CfEaNP9iMtYD7dg5kh05iFtXIYsWta0DckYC/tDMwv9W
hdC54a+F/oIR05w7BNFOzROe1rwPF5VBbH6HzoX0XeBL1BQzj0fqDKjIfl6VIuDh
HwgsrG59KA/Q95m6mNYON2XQV71sdcRVxC+mm2zSLIm9N0H+CxGNojJzk5NpQdga
HSyMyYIfhJLLkXFsnzBb6tcBlM0p88DtljVCRDKyjEYRtgl5tu6FoOJ+ggFAxy0W
hYCsRaRpRHIy6zO4oMKnjnCRw0S0cQK5S2TLFtFsm7/IP63bLh5Gl5HY2Tg/HZM8
JF1zDReq5LR2oq3an+WkWDcNiFLPhv94w3l+VePHurhT5dTeOo24tlOBMqcDJGj7
hiVSF0sTzDjXGMYwOyJxqoNC6btYc0PwtJNmnRR4jMwoRIzJ4AakrBnBZeFfd20A
zeg7V+Zdbbt3z1pUC4+4g9c7Kf52a8go9mxAzQehlo4/mcKHKQFLSyFhy6fjG+Ur
GoYTODSzFR1JuQhxdmicuy4sJzzbWGWWbiOampowxC2kCJG1R4oO3y/c3P6nBK4u
rrKkx+0Qc0sThCsS++xvi0n3rag7OEWLFBHNDdt0rJ5G7N3ZukPhi75+9FzJqFeL
jM2zDpzAWmj8dMuQrj4g3PpAeWhSbazPYlq05QbO7iipbVaL03M=
=pzKl
-----END PGP SIGNATURE-----

--nextPart1623673.fgYYGVVioI--

