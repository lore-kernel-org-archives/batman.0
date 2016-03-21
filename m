Return-Path: <hwhilse@gmail.com>
From: Hans-Werner Hilse <hwhilse@gmail.com>
Date: Mon, 21 Mar 2016 10:03:52 +0100
Message-Id: <1458551033-8734-1-git-send-email-hwhilse@gmail.com>
Subject: [B.A.T.M.A.N.] [RFC] alfred: implement TCP support for
	server-to-server
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
Cc: Hans-Werner Hilse <hwhilse@gmail.com>

As announced in A.L.F.R.E.D. issue #202 (https://www.open-mesh.org/issues/202),
I gave implementing server-to-server communication via TCP a spin.

The result is this - rather large - patch. I'd be glad for comments on the
implementation. Also, I might split this into more commits, but I think I need
ideas on how to properly separate the various parts - they mostly make sense
to me as a unit only.

A rough overview:

alfred.h:
* struct tcp_connection is new, stores socket fd, pointer to data buffer,
  a counter for data already read from socket (TCP is a stream and we can't
  rely on self-contained datagrams), and list management
* struct interface is extended by a socket fd for the TCP socket and
  a list of "tcp_connection"s
* struct globals is extended by a "requestproto" field that stores desired
  operation mode.

main.c:
* TCP operation is for now triggered by a command line flag "-t".

netsock.c:
* for each interface, a TCP socket, bound/listening, is created and teared
  down along with the UDP sockets
* a list of tcp_connection sockets is kept, managed and cleared alongside
* the sockets are incorporated into the fd_set management for select()

recv.c:
* process_alfred_request() gets another argument for a socket fd. It just
  gets handed over to push_data() for sending the reply over the same
  socket the request came from.
* recv_alfred_stream() is new and the analog function to recv_alfred_packet().
  It manages the data buffer and will act on a received packet if and when
  it is completely received.
  ALFRED_REQUEST, ALFRED_PUSH_DATA and ALFRED_STATUS_TXEND packets are
  handled for now.

send.c:
* connect_tcp() function for setting up a new connection to a (TCP) server
* push_data() gets a new argument for a socket fd (c.f.
  process_alfred_request() in recv.c). If said argument is >=0, the function
  will operate on the socket rather than recvmsg() a datagram.
* sync_data() will act on requestproto configuration in globals struct and
  opt to make the sync via TCP if configured to do so
* send_alfred_stream() will use connect_tcp() to create a new connection,
  then send a packet analog to send_alfred_packet() and will then register
  the socket to the list of "tcp_connection"s for the interface it is
  currently operating upon. This way, the socket can receive a reply and
  will be handled as long as it is not closed on the other end.

server.c:
* check_if_socket() will tear down the TCP server and client sockets
  along with the UDP sockets

unix_sock.c:
* depending on the globals' requestproto setting, a REQUEST will be send
  via TCP rather than UDP.


Testing has been only in an artificial virtual setup for now. I have some
hopes to get "mission clearance" for giving it a spin in our local
"Freifunk" setup. Even then TCP will most certainly only be used on a
handful of gateways since on the majority of nodes, reading values from
A.L.F.R.E.D. is not really needed (they are mostly push-only).

I'd be glad to hear some feedback.

-hwh


Hans-Werner Hilse (1):
  alfred: implement TCP support for server-to-server communication

 alfred.h    |  24 +++++++++-
 main.c      |   8 +++-
 netsock.c   | 148 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 recv.c      |  88 ++++++++++++++++++++++++++++++++++--
 send.c      | 119 +++++++++++++++++++++++++++++++++++++++++++-----
 server.c    |  11 +++++
 unix_sock.c |   8 ++++
 7 files changed, 389 insertions(+), 17 deletions(-)

-- 
2.7.3

