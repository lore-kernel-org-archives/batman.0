Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 3 Apr 2013 19:16:04 +0800
References: <20130330150907.GE4024@ritirata.org>
 <1364660520-18385-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1364660520-18385-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304031916.04253.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: do not silently ignore
	wrong condition
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

On Sunday, March 31, 2013 00:22:00 Antonio Quartulli wrote:
> Only one neigh_node per orig_node should match a given
> neighbor address, therefore, if more than one matching
> neigh_node is found, a WARNING has to be triggered to let
> the user know that something is wrong in the originator
> state instead of silently skipping the error.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> v2:
> - fixed closing parenthesis
> 
>  bat_iv_ogm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision c969b9e.

Thanks,
Marek
