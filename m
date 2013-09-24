Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 24 Sep 2013 20:25:53 +0800
Message-ID: <7713506.B9Eh2S0lu4@diderot>
In-Reply-To: <1379874410-3354-1-git-send-email-antonio@meshcoding.com>
References: <1379874410-3354-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: no need for return in
	void functions
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

On Sunday 22 September 2013 20:26:50 Antonio Quartulli wrote:
> Only network-coding.h is using "return;" inside void stub
> functions. This is not a consistent with the rest of the code,
> therefore don't continue to do as such.
> (Other stub functions will be cleaned later)
> 
> Introduced by 7dd9d8992b0c197ba656a6d9a70966cea10fc2d9
> ("batman-adv: tvlv - add network coding container")
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  network-coding.h | 1 -
>  1 file changed, 1 deletion(-)

Applied in revision 96cebef.

Thanks,
Marek

