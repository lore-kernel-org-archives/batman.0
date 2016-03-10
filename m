Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 10 Mar 2016 15:55 +0100
Message-ID: <4750317.OxPK4g4mQE@prime>
In-Reply-To: <1456492790-29897-1-git-send-email-apape@phoenixcontact.com>
References: <1456492790-29897-1-git-send-email-apape@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1961532.a7Hu3OFxqx";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 7/7] batman-adv: handle race condition
	for claims between gateways
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

--nextPart1961532.a7Hu3OFxqx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Andreas,

On Friday 26 February 2016 14:19:50 Andreas Pape wrote:
> Consider the following situation which has been found in a test setup:
> Gateway B has claimed client C and gateway A has the same backbone
> network as B. C sends a broad- or multicast to B and directly after
> this packet decides to send another packet to A due to a better TQ
> value. B will forward the broad-/multicast into the backbone as it is
> the responsible gw and after that A will claim C as it has been
> chosen by C as the new gateway. If it now happens that A claims C
> before it has received the broad-/multicast forwarded by B (due to
> backbone topology or due to some delay in B when forwarding the
> packet) we get a critical situation: in the current code A will
> immediately unclaim C when receiving the multicast due to the
> roaming client scenario although the position of C has not changed
> in the mesh. If this happens the multi-/broadcast forwarded by B
> will be sent back into the mesh by A and we have looping packets
> until one of the gateways claims C again.
> In order to prevent this, unclaiming of a client due to the roaming
> client scenario is only done after a certain time is expired after
> the last claim of the client. 100 ms are used here, which should be
> slow enough for big backbones and slow gateways but fast enough not
> to break the roaming client use case.

That's an interesting solution. My original idea was to make clients "race" 
for clients, which wasn't ever implemented because in the scenarios I tested 
this was not a problem (Check batadv_bla_rx(), there is a note on a possible 
optimization).

I believe your solutions looks valid, let's implement that.

Acked-by: Simon Wunderlich <sw@simonwunderlich.de>

Thanks,
     Simon
--nextPart1961532.a7Hu3OFxqx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW4YrEAAoJEKEr45hCkp6hnCcQAITidiAAwatfA8ll6ZG0KsL+
KfBff10fa8h/fzzx5eN9HSY2bzaho/pH9QrvtmqaG+Hcc10B4oXfXcKsuTwyl/gV
3H8q8pAyoxxpxYj08nxtOyv/0yJQ/o1Sw+7KEYa2KmVx2zLx0VzpF8ByBwuYTpZ6
H5oUGTxXzDlJNTMlPt3253b08uJ01GCNXtSg55yWafvawykSejahqK7nhasEwEkH
HQrNavW/+ABi8yW/A7RDFyXtmsBEe1nuhEA5k746HCGAmThwnp8VnvXK5Z/T/kLc
Sx5VGv67FAJMaE+TOl8C8aZZmvpcrlNQyqp8Gj0pAa7TO+bBe1+nDHItjpt2PSuF
MXPVFULsD4rnuoJNUWi1VebPLaAum01MGh1B1n2Y/nlcEGVvTKEw9j7aPEUjEq/M
orRbrLCATTil1WskdLkHIAbrkBo17jwaiFyZ3DKX0JdXwMGnL6C1J2CGGHJF4fxB
lceoTq35kCNhN5xAJmztk3jk/1YSRL3L9MObk7/2M09Ka10pYlMDZEq7XWxxV4IV
bMj5vaf3KP9s5WhwZeYX1/SErlgUCD6CAP0tQ1dwNKyvLsbFMUemLCpRz8nArbjx
0VmGdM4iCRfF+4dN0p97m88cjamGcnvVyPgxVAlfSGuDNMz3pq3PmAApKNUcMNFK
kbAzm8+5pFcNcunGqE5p
=dJAM
-----END PGP SIGNATURE-----

--nextPart1961532.a7Hu3OFxqx--

