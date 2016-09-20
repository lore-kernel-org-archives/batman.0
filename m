Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 20 Sep 2016 16:24:18 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160920142418.GA7375@otheros>
References: <35819279.yt4EnXKmx6@bentobox>
 <1468423822-28324-1-git-send-email-sven@narfation.org>
 <1468423822-28324-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1468423822-28324-2-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/7] batctl: Add command to
 create/destroy batman-adv interface
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Wed, Jul 13, 2016 at 05:30:17PM +0200, Sven Eckelmann wrote:
> The command "new" can be used to create a batman-adv interface without any
> interface attached. This is helpful when the interfaces should be
> configured independently of the first attached interface.

Like in the title of this mail, maybe naming the commands
"create" and "destroy" instead of "new"/"destroy"?

The former sounds slightly more antonymic to me.
