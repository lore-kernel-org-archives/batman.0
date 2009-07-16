Return-Path: <antoine@7degrees.co.za>
Message-Id: <F0997A98-262F-4E4A-907A-22E1BDC86CB2@7degrees.co.za>
From: Antoine van Gelder <antoine@7degrees.co.za>
In-Reply-To: <200907152050.18936.sven.eckelmann@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Apple Message framework v935.3)
Date: Thu, 16 Jul 2009 07:49:44 +0200
References: <1739bfe0907150649l61d6b0dga6825e84dc45832d@mail.gmail.com>
	<200907151556.32314.sven.eckelmann@gmx.de>
	<1739bfe0907150726l70ee35b1wa92f4fb1aabfdd61@mail.gmail.com>
	<200907152050.18936.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [vis] fixed partial json output
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


If I can chime in with my 5 cents,


On 15 Jul 2009, at 20:50 , Sven Eckelmann wrote:

>> Thanks, is this better?
> There are different things I don't understand complete. How does the =20=

> receive
> buffer affect the output buffer in this case?


Without spending a day rooting through the syscall implementation I'm =20=

not sure why this is the case. Neither the documentation nor Google =20
has been much help beyond revealing that:

   * It is a widespread phenomena where writes are getting truncated =20
when there is unread data on the socket.

   * There exists many opinions and precious little consensus on the =20
precise semantics of read(2) and write(2) !

Oy vey.


> Isn't it possible to disable non-blocking sockets in vis.c:635-638 =20
> and change
> the read to following for json: Try to recv data until the read =20
> fails or an
> empty line (please check HTTP rfc before implementing) appears. If =20
> the read
> fails -> discard everything. If the empty line appeared then send =20
> the data.
> You should create an extra function to read (and discard) the header =20=

> stuff.


If everyone else thinks this is a good idea I would also greatly =20
prefer to modify the vis server to use blocking sockets.

Given that it is a threaded implementation it is not immediately =20
obvious to me why this approach was chosen originally unless the =20
threading got added later?

Thoughts anyone?


> My personal opinion about the errno and delay stuff is... I don't =20
> like it. It
> seems to be somewhat correct to ask again on EAGAIN corresponding to =20=

> the man
> page, but we could do it in a cleaner way if possible.


*nod*

It _is_ ugly. It is simulating blocking behavior on a non-blocking =20
object which, really, means that one should ideally just be using a =20
blocking object in the first place!

:-D


> Maybe someone sees a problem in my proposal. The only thing I see is =20=

> that the
> read should appear before locking the current buffer or a "bad =20
> person" (me)
> could delay the new buffers for all others by connecting and then =20
> wait for a
> long time. I see the same problem in your current implementation.



I'm not sure the current implementation performs a read between locks =20=

but I agree that the server should not block other connections while =20
waiting for a response from another connection.


Thank you for the code review Sven!

  - antoine


--
http://7degrees.co.za
"Libr=E9 software for human education."



