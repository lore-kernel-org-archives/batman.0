Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 07:52:42 +0200
Message-ID: <1580619.BbQOVpWRpd@sven-edge>
In-Reply-To: <1461875848-11720-2-git-send-email-andrew@lunn.ch>
References: <1461875848-11720-1-git-send-email-andrew@lunn.ch>
 <1461875848-11720-2-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [PATCH 01/10] batman-adv: Handle parent
	interfaces in a different netns
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

On Thursday 28 April 2016 22:37:19 Andrew Lunn wrote:
> batman-adv tries to prevent the user from placing a batX soft
> interface into another batman mesh as a hard interface. It does this
> by walking up the devices list of parents and ensures they are all
> none batX interfaces. iflink can point to an interface in a different
> namespace, so also retrieve the parents name space when finding the
> parent and use it when doing the comparison.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Antonio Quartulli <a@untable.cc>
> ---

You are unfortunately reverting back to an older version of the patch which is 
harder to make compile on older kernels.

Kind regards,
	Sven
