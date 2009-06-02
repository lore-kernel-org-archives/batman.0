MIME-Version: 1.0
In-Reply-To: <1243965365-6526-1-git-send-email-sven.eckelmann@gmx.de>
References: <200906021950.07235.sven.eckelmann@gmx.de>
	<1243965365-6526-1-git-send-email-sven.eckelmann@gmx.de>
Date: Tue, 2 Jun 2009 13:56:03 -0500
Message-ID: <4313f3060906021156r1920d42bp632d49bd0c37173e@mail.gmail.com>
From: Nathan Wharton <naw@greptar.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] [batman] Align pointers in hna list
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

On Tue, Jun 2, 2009 at 12:56 PM, Sven Eckelmann <sven.eckelmann@gmx.de> wrote:
> Architectures like SuperARM or Xscale needs aligned data for multi-byte
> operations. GCC can create instructions sequences for packed data, but
> must know that something will not be aligned. Since list_add will
> operate on untyped data over void-pointers it cannot know that
> hna_global_entry is packed and will create only a fast and unsafe
> version for load and store operations.
> It is only important for the first 5 bytes of hna_global_entry to be
> packed we can force these elements to be aligned without changing
> the relative addresses of the first bytes.
>

It looks good here.  I am running this combined with the previous 3
patches with cpu/alignment set to bus error on problems.
