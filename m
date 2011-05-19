Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 19 May 2011 10:07:04 +0200
References: <1305407694-16789-1-git-send-email-sven@narfation.org>
	<1305407694-16789-9-git-send-email-sven@narfation.org>
In-Reply-To: <1305407694-16789-9-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201105191007.04614.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 9/9] batman-adv: Calculate sizeof using
	variable insead of types
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Saturday 14 May 2011 23:14:54 Sven Eckelmann wrote:
> Documentation/CodingStyle recommends to use the form
> 
>         p = kmalloc(sizeof(*p), ...);
> 
> to calculate the size of a struct and not the version where the struct
> name is spelled out to prevent bugs when the type of p changes. This
> also seems appropriate for manipulation of buffers when they are
> directly associated wi

Applied in revision 1929981.

Thanks,
Marek
