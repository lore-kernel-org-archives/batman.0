Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 16 Mar 2013 18:21:59 +0800
References: <b6b8ee26c56ef0c28d1efe1c54218c4d7090bd98.1362863832.git.mschiffer@universe-factory.net>
 <b6b8ee26c56ef0c28d1efe1c54218c4d7090bd98.1362867238.git.mschiffer@universe-factory.net>
In-Reply-To: <b6b8ee26c56ef0c28d1efe1c54218c4d7090bd98.1362867238.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201303161821.59287.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 1/2] batman-adv: split
	batadv_is_wifi_iface() into two functions
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

On Sunday, March 10, 2013 06:14:22 Matthias Schiffer wrote:
> Previously batadv_is_wifi_iface() did two things at once: looking up a
> net_device from an interface index, and determining if it is a wifi device.
> 
> The second part is useful itself when the caller already has a net_device
> reference.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
>  hard-interface.c | 73
> +++++++++++++++++++++++++++++++------------------------- 1 file changed,
> 41 insertions(+), 32 deletions(-)

Applied in revision a75dbf4.

Thanks,
Marek


PS: Every new function is required to have kernel doc. This time I filled in 
the missing pieces but please do so in the future.
