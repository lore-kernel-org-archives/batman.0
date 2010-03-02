Return-Path: <andrew@lunn.ch>
Date: Tue, 2 Mar 2010 07:43:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100302064308.GA733@lunn.ch>
References: <20100123174616.GA4795@Sellars> <20100126061311.GA12697@Sellars>
	<20100129082545.GI7844@lunn.ch>
	<201001291659.59677.lindner_marek@yahoo.de>
	<20100130165059.GV24649@lunn.ch> <20100211094659.GH2900@lunn.ch>
	<20100211100156.GI2900@lunn.ch>
	<20100228163428.GA15370@pandem0nium>
	<20100301055955.GC15286@lunn.ch>
	<20100301165706.GA11578@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100301165706.GA11578@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] slowpath warning
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

On Mon, Mar 01, 2010 at 05:57:06PM +0100, Simon Wunderlich wrote:
> Hey Andrew,
> 
> all list-adds and list-removes do a kref_get or kref_put respectively,
> but that probably was not very clear. As soon as a refence is created 
> (by linking into the hash or a list), we should also kref_get() it.
> 
> Please find attached a new version of this patch with separate 
> send_list_add/remove functions which include the put/get functions. 
> I've also added the kref_put/get call to the send_list loop again.
> It should look more balanced now. Tested in my 9 qemu setup again,
> no memory leaks or crashes but i only did a very quick test 
> (15 minutes)

Hi Simon

This looks better. Did it survive longer testing? 

     Andrew
