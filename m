From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 2 Jun 2009 12:36:41 +0800
References: <4313f3060905190727x279f2d0boc4e74e4df6e821bc@mail.gmail.com>
	<4313f3060906011103q21b32600nf99f8607bd01045c@mail.gmail.com>
	<200906012135.22488.sven.eckelmann@gmx.de>
In-Reply-To: <200906012135.22488.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906021236.42019.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] [batman] Add padding around allocation
	debugger structures
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
To: b.a.t.m.a.n@open-mesh.net

On Tuesday 02 June 2009 03:35:07 Sven Eckelmann wrote:
> So my question to marek: Is it really needed to have "struct
> hna_global_entry" packed in hna.h:57? If not then we should remove it and
> this problem should be gone. And what is with "struct hna_element".

The first 5 bytes of both structs are used as base for the hash index. If the 
compiler changes the order or something similar it might not work.

Regards,
Marek

