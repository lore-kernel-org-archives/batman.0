Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 16 Mar 2013 18:31:37 +0800
References: <b6b8ee26c56ef0c28d1efe1c54218c4d7090bd98.1362863832.git.mschiffer@universe-factory.net>
 <b6b8ee26c56ef0c28d1efe1c54218c4d7090bd98.1362867238.git.mschiffer@universe-factory.net>
 <011ead7529e3c7e2b2a906cae3b1e8c8e3e40967.1362867238.git.mschiffer@universe-factory.net>
In-Reply-To: <011ead7529e3c7e2b2a906cae3b1e8c8e3e40967.1362867238.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201303161831.37314.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 2/2] batman-adv: send each broadcast
	only once on non-wireless interfaces
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

On Sunday, March 10, 2013 06:14:23 Matthias Schiffer wrote:
> While it makes sense to send each broadcast thrice on 802.11 (WLAN)
> interfaces as broadcasts are often unreliable on these, there is no reason
> to do so on other interface types.
> 
> The increased the overhead can be harmful on low-bandwidth links like VPN
> connections over slow internet lines, therefore it is better to reduce the
> number of broadcast packets sent on non-wireless links to one.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
>  hard-interface.c | 4 ++++
>  main.h           | 5 +++++
>  send.c           | 5 ++++-
>  types.h          | 1 +
>  4 files changed, 14 insertions(+), 1 deletion(-)

Applied in revision cc1fde3.

Thanks,
Marek


PS: Also struct definitions require kernel doc ..
