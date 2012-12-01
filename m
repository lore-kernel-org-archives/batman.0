Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 1 Dec 2012 23:32:18 +0800
References: <1353889649-19264-1-git-send-email-ordex@autistici.org>
 <20121126103531.GA23570@pandem0nium>
In-Reply-To: <20121126103531.GA23570@pandem0nium>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201212012332.19073.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: don't compile the BLA switch
	if not requested
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

On Monday, November 26, 2012 18:35:31 Simon Wunderlich wrote:
> On Mon, Nov 26, 2012 at 01:27:29AM +0100, Antonio Quartulli wrote:
> > When the Bridge Loop Avoidance component is not compiled-in, its boolean
> > switch should be not compiled as well. This patch surrounds the switch
> > with a proper ifdef.
> >
> > This behaviour was introduced by 9fd6b0615b5499b270d39a92b8790e206cf75833
> > ("batman-adv: add bridge loop avoidance compile option")
> >
> > Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> 
> Acked-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Applied in revision c13023b.

Thanks,
Marek
