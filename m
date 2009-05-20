From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 21 May 2009 01:30:01 +0800
References: <1242819232-614-3-git-send-email-sven.eckelmann@gmx.de>
	<1242836756-2491-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1242836756-2491-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905210130.01798.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH2/2v2] [batman] Don't add size for netlink
	header twice in netlink request
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

On Thursday 21 May 2009 00:25:56 Sven Eckelmann wrote:
> The parameter len of NLMSG_LENGTH is only the size of the payload of
> the request. If we use this function to calculate the size of the buffer
> we send to the kernel we would add (sizeof(nlmsghdr)+padding) and the
> size of our own structure which also has a nlmsghdr included. We must
> split the req structure into a header part and the payload to calculate
> the correct size of our buffer and having the payload always start at
> the correct address.
>
> Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>

Great findings - the patches are in now.  :-)

Regards,
Marek

