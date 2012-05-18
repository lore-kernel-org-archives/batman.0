Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 18 May 2012 23:03:26 +0800
References: <1779270.uUsuEFyTM4@sven-desktop.home.narfation.org>
	<1337192605-8652-1-git-send-email-sven@narfation.org>
	<1337192605-8652-11-git-send-email-sven@narfation.org>
In-Reply-To: <1337192605-8652-11-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205182303.26867.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 11/13] batman-adv: Directly print to
	seq_file in vis
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

On Thursday, May 17, 2012 02:23:23 Sven Eckelmann wrote:
> The vis output doesn't need to be buffered in an character buffer before it
> can be send to the userspace program that reads from the vis debug file.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  vis.c |  228
> ++++++++++++++++++++++++----------------------------------------- 1 file
> changed, 83 insertions(+), 145 deletions(-)

Applied in revision 6977ef4.

Thanks,
Marek
