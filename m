Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 3 Jul 2009 07:32:28 +0800
References: <1739bfe0907020513m78e06c83s980ce88b5cb5cca5@mail.gmail.com>
In-Reply-To: <1739bfe0907020513m78e06c83s980ce88b5cb5cca5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907030732.38935.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] json output from vis server would fail
	with incomplete writes
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


Hi,

> We are using B.A.T.M.A.N as a mesh networking software. We ran into a bug
> which occurred with web browser whereby the  data written back through the
> socket was not complete thereby causing an error with our program.
>
> The fix works by making sure that all the data that is to be sent in the
> send_buffer is sent. It checks the value of ret until it equals the size of
> the data to be sent.

thanks for your patch. This spot you found really is not that beautiful.  ;-)
Looking at your patch I ask myself what will happen if the other end dies in 
the process ? You are in a loop that constantly checks if all data has been 
transmitted and retries to send without checking for timeout errors or 
connection problems. I have the feeling it could lead to an endless loop. I 
might be wrong - what do you think ?
Also, I never used fsync on a socket. It is doing the same thing as on a file ? 
What about using the SIOCOUTQ ioctl (which is linux specific and not 
portable) ?

Regards,
Marek

