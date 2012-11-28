Return-Path: <lmy19901031@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CALDpWg5UxkqP2_f-waB===fDPHg6vC0xf8=oxVx7aH5XvXd6uQ@mail.gmail.com>
References: <CALDpWg5UxkqP2_f-waB===fDPHg6vC0xf8=oxVx7aH5XvXd6uQ@mail.gmail.com>
Date: Wed, 28 Nov 2012 18:02:19 -0500
Message-ID: <CALDpWg7F3MNsy5gtcP=pcd0R_tFUmCTsyZ-K9bYMnCf0-YmArQ@mail.gmail.com>
From: liu muye <lmy19901031@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] batman-adv: Raw Socket Communication
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

One follow up question:

When I do batctl o. It shows the MAC address of my network interface.
In my case, is ah0.
Not sure what to do in order to show the MAC address of the bat0.

Thanks
Muye Liu

On Tue, Nov 27, 2012 at 11:15 PM, liu muye <lmy19901031@gmail.com> wrote:
> Hello:
>
> This is Muye again. I have encountered another problem recently when I
> am using B.A.T.M.A.N to do the socket programming.
>
> Currently, I have three nodes. Namely, node A, node B, and node C. The
> testing environment is a hall way in our department.
>
> I put node A in one end of the hall way, node C in another end of the
> hall way. Node B is in the middle of the hall way.
>
> I can ping node C from node A and vice versa. In node A, I can
> traceroute to node C. The traceroute shows it needs to go through node
> B.
>
> However, when I send packet from node A to node C. Node C does not
> receive anything. But if I send packet from node A to node B, node B
> can receive that packet.
> Not sure what happened.  The link shown below is the program I used to
> send packet. Both source and destination are MAC address.
>
> https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/attachments/20111206/52f060cb/attachment.c
>
> I greatly appreciate any suggestion, comment, and help.
>
> Thanks
