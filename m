From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 3 Jun 2009 19:16:50 +0800
References: <1243965365-6526-1-git-send-email-sven.eckelmann@gmx.de>
	<1244025566-13147-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1244025566-13147-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906031917.19638.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] [batman] Align pointers in hna list
	elements
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

On Wednesday 03 June 2009 18:39:26 Sven Eckelmann wrote:
> Architectures like SuperARM or Xscale needs aligned data for multi-byte
> operations. GCC can create instructions sequences for packed data, but
> must know that something will not be aligned. Since list_add will
> operate on untyped data over void-pointers it cannot know that
> hna_global_entry is packed and will create only a fast and unsafe
> version for load and store operations.
> It is only important for the first 5 bytes of hna_global_entry to be
> packed we can force these elements to be aligned without changing
> the relative addresses of the first bytes.


Sven, thanks a lot for your patches and thanks for your debugging help, 
Nathan. I just applied these patches. :-)

Regards,
Marek

