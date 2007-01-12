From: axel <axel@notmail.org>
Subject: Re: [B.A.T.M.A.N.] freifunk-batman-de (0.73 "vampimated")
Date: Fri, 12 Jan 2007 22:10:31 +0100
References: <BAY123-F16148B561C214A87986E31C9B00@phx.gbl>
In-Reply-To: <BAY123-F16148B561C214A87986E31C9B00@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701122210.31995.axel@notmail.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Hi,

I also believe hard coded address ranges should not be, but despite that I 
would like to ask whether it would be possible for you to move over to the 
105 address range. This would also help to once link the clouds together.

Another point is, that there is also a batman-experimental project in 
development which comes up with some new features to measure link quality and 
apply strange routing metrics and I thought that in case it would ever be 
employed it could use the 103 address range to avoid routing conflicts.

best regards,
axel

On Friday, 12. January 2007 18:27, Felix Bolte wrote:
> but the output of "ip route" is still hardcoded to an 105.* address range
>
> can you fix this in the next version? we use 103.* ... you should already
> know ... but in general it is better to make the fiilter dynamic, referred
> to the used network
